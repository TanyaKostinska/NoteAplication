import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes_aplication/add_item_to_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  String stringLocalNote = '';
  List<String> stringList = [];

  @override
  void initState() {
    super.initState();
    getNote();
  }

  Future<void> saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('noteString', nameController.text);
    nameController.clear();
  }

  Future<void> getNote() async {
    Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      stringLocalNote = prefs.getString('noteString') ?? '';
      stringList = prefs.getStringList('List') ?? [];
    });
  }

  Future<void> saveToList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('List', stringList);
  }

  void addToList() {
    setState(() {
      stringList.add(nameController.text);
    });
    saveToList();
  }

  Future<void> remove(index) async {
    setState(() {
      stringList.removeAt(index);
    });
  }

  Future<void> navigator(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddItemToListPage()),
    );
    setState(() {
      stringList.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: const Row(
          children: [
            Icon(
              Icons.note_alt_rounded,
              color: Colors.black,
              size: 35,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.add_circle_outline),
              ),
              onSubmitted: (String value) {
                debugPrint(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: addToList,
                child: const Text('Add'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: stringList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(stringList[index]),
                          Text(index.toString()),
                          ElevatedButton(
                            onPressed: () {
                              remove(index);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigator(context);
        },
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
