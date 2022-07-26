import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sqlite/provider/todos.dart';
import 'package:todo_sqlite/screen/add_todo.dart';
import 'package:todo_sqlite/screen/edit_todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => Todos(),
                child: const AddTodo(),
              ),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add_task),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text('Todos'),
      ),
      body: FutureBuilder(
        future: todos.getTodo(),
        builder: (context, snapshot) {
          if (todos.itemTodo.isEmpty) {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: todos.itemTodo.length,
              itemBuilder: ((context, index) {
                final todo = todos.itemTodo[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => Todos(),
                        child: EditTodo(
                          id: todo.id,
                          title: todo.title,
                          description: todo.description,
                        ),
                      ),
                    ),
                  ).then((value) => setState(() {})),
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text(
                                    'Apakah ingin menghapus data ini?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Tidak'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      todos.deleteTodo(todo.id);
                                      setState(() {});
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Data berhasil dihapus!'),
                                        ),
                                      );
                                    },
                                    child: const Text('Yes'),
                                  )
                                ],
                              );
                            },
                          );
                        }),
                  ),
                );
              }),
            );
          }
        },
      ),
    );
  }
}
