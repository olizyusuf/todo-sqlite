import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite/db/database_manager.dart';
import 'package:todo_sqlite/model/todo_model.dart';

class Todos with ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  List<TodoModel> itemTodo = [];

  DatabaseManager database = DatabaseManager.instance;

  void addTodo() async {
    isLoading = true;
    notifyListeners();
    Database db = await database.db;
    await db.insert(
      'todos',
      {
        'title': titleController.text,
        'description': descriptionController.text,
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> getTodo() async {
    Database db = await database.db;
    List<Map<String, dynamic>> data = await db.query('todos');

    itemTodo.clear();

    for (var item in data) {
      itemTodo.add(
        TodoModel(
            id: item['id'],
            title: item['title'],
            description: item['description']),
      );
    }
  }

  Future deleteTodo(int id) async {
    Database db = await database.db;
    db.delete('todos', where: 'id = $id');
  }

  Future editTodo(int id) async {
    Database db = await database.db;

    db.update(
      'todos',
      {
        'title': titleController.text,
        'description': descriptionController.text,
      },
      where: 'id = $id',
    );
  }
}
