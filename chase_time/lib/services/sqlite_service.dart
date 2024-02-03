import 'package:chase_time/models/info_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    path += "/database.db";
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE info(id INTEGER PRIMARY KEY AUTOINCREMENT,
          failureCount INTEGER NOT NULL,
          successCount INTEGER NOT NULL,
          timeupCount INTEGER NOT NULL,
          attemptCount INTEGER NOT NULL
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> createRecord(InfoModel info) async {
    final Database db = await initializeDB();
    await db.insert(
      'info',
      info.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<InfoModel>> getItems() async {
    final db = await SqliteService.initializeDB();
    final List<Map<String, dynamic>> list = await db.query('info');
    return list.map((e) => InfoModel.fromMap(e)).toList();
  }
}
