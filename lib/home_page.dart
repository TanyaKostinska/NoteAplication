import 'package:flutter/material.dart';

import 'models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> noteList = [
    NoteModel(
        name: 'Замiтка 1',
        description: 'Завершити проект',
        deadline: 'Впродовж тижня'),
    NoteModel(
        name: 'Замiтка 2',
        description: 'Запланувати новий проект',
        deadline: 'До настуного понедiлка')
  ];

  final TextEditingController noteController = TextEditingController();

  void addNotes (){}

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
      body: noteList.isEmpty
          ? const Center(child: Text('Ваш список пустий, додайте нову замiтку'))
          : ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text( noteList[index].name + ' ' + noteList[index].description),

                );
              },
            ),

      //  Column(
      //   children: [
      //     SizedBox(height: 20),
      //   ],
      // );
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogAddContact,
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }

  void _showDialogAddContact() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Додати нову замітку'),
            content: SizedBox(
              width: 250,
              height: 250,
              child: ListView(
                children: [
                  TextField(
                    controller: noteController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text('Введiть короткий опис замiтки'),
                      hintText: 'короткий опис ',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    onTap: (){},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    noteList.add(NoteModel(name: noteController.text, description: '', deadline: ''),);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Add',
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Close',
                ),
              ),
            ],
          );
        });
  }
}
