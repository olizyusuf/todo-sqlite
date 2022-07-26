import 'package:flutter/material.dart';
import 'package:todo_sqlite/provider/todos.dart';
import 'package:todo_sqlite/screen/todo_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => Todos(),
        child: const TodoScreen(),
      ),
    );
  }
}
