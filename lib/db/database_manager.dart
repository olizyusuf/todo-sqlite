import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._privateConst();
  static DatabaseManager instance = DatabaseManager._privateConst();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDB();
      return _db!;
    } else {
      return _db!;
    }
  }

  Future _initDB() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(docDirectory.path, 'todo.db');
    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      return await database.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT
          )
          ''');
    });
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
