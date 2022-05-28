import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage/constant/app_key.dart';
import 'package:storage/model/task_model.dart';

class DatabaseHelper {
  static const String _dbName = 'storage.db';
  static const int _dbVersion = 1;
  static const String _table = 'task';

  DatabaseHelper._instance();

  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _init();
  }

  _init() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_table (
          ${AppKey.kId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${AppKey.kTitle} TEXT NOT NULL
        )
        ''');
  }

  Future<int> insert(TaskModel task) async {
    Database db = await instance.database;
    int res = await db.insert(_table, task.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> fetchAll() async {
    Database db = await instance.database;
    var res = await db.query(_table, orderBy: "${AppKey.kId} DESC");
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_table, where: '${AppKey.kId} = ?', whereArgs: [id]);
  }

  Future<void> clear() async {
    Database db = await instance.database;
    await db.rawQuery('DELETE FROM $_table');
  }
}
