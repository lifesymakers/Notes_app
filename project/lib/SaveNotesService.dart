import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NotesSaver {
  static final _dbName = 'notes.db';
  static final _dbVersion = 1;

  NotesSaver._constructor();
  static final NotesSaver instance = NotesSaver._constructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    return await _initializeDB();
  }

  Future<Database> _initializeDB() async {
    final dir = await getApplicationDocumentsDirectory();
    String path = dir.path + _dbName;
    return await openDatabase(path, version: _dbVersion,
        onCreate: (db, version) async {
      db.setVersion(version);
      await db.execute('''
        CREATE TABLE notes(title TEXT NOT NULL, note TEXT NOT NULL, date TEXT NOT NULL)
      ''');
    });
  }

  Future<List<Map<String, dynamic>>> getAllNotes(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> insert(Map<String, dynamic> newData, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, newData);
  }

  Future<int> deleteFromDB(String title) async {
    Database db = await instance.database;
    return await db.delete('notes', where: 'title = ?', whereArgs: [title]);
  }
}
