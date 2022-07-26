import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite/provider/todos.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text('Add Todo'),
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
                hintText: 'title...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 201, 201, 201)),
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
                hintText: 'description...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 201, 201, 201)),
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
                  todos.addTodo();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data berhasil ditambah!'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data tidak boleh kosong!'),
                    ),
                  );
                }
              },
              child: Text(todos.isLoading ? "Loading..." : "Add"),
            )
          ],
        ),
      ),
    );
  }
}
