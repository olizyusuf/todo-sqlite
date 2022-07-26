import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite/provider/todos.dart';

class EditTodo extends StatelessWidget {
  final int id;
  final String description;
  final String title;
  const EditTodo(
      {Key? key,
      required this.id,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);

    todos.titleController.text = title;
    todos.descriptionController.text = description;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: todos.titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: todos.descriptionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (todos.titleController.text.isNotEmpty &&
                    todos.descriptionController.text.isNotEmpty) {
                  todos.editTodo(id);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data berhasil diubah!'),
                    ),
                  );
                }
              },
              child: const Text("Edit"),
            )
          ],
        ),
      ),
    );
  }
}
