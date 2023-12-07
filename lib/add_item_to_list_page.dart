import 'package:flutter/material.dart';
import 'package:notes_aplication/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemToListPage extends StatefulWidget {
  const AddItemToListPage({super.key});

  @override
  State<AddItemToListPage> createState() => _AddItemToListPageState();
}

class _AddItemToListPageState extends State<AddItemToListPage> {
  TextEditingController nameController = TextEditingController();

  Future<void> savePush() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('String', nameController.text);
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додати в нотатки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, nameController.text);
              },
              child: const Text('Push'),
            ),
          ],
        ),
      ),
    );
  }
}
