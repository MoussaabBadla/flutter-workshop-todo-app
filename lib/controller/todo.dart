import 'package:myapp/model/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoController {
  static Database? _dataBase;

  final String _tableName = 'todos';

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase!;
    _dataBase = await initDB();
    return _dataBase!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    final db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table todos ( 
      id integer primary key autoincrement, 
      title text not null,
      isCompleted integer not null)
      ''');
    });

    return db;
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    return db.insert(_tableName, todo.toMap());
  }

  Future<List<Todo>> getTodos() async {
    Database db = await database;
    final List<Map<String, dynamic>> list = await db.query(_tableName);
    return List.generate(list.length, (index) => Todo.fromMap(list[index]));
  }

  
}
