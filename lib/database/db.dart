import 'package:sqflite/sqflite.dart';

abstract class IDatabase {
  Future<void> init();
  Future<void> createTable(Database db);
  Future<int> insertData(Map<String, dynamic> data);
  Future<List<Map>> getData();
  Future<void> updateData(Map<String, dynamic> data);
  Future<void> deleteData(int id);
  Future<void> closeDatabase();
}

class TimerDatabase implements IDatabase {
  late Database _db;

  static final TimerDatabase _internal = TimerDatabase._();

  TimerDatabase._();

  factory TimerDatabase() => _internal;

  @override
  Future<void> init() async {
    _db = await openDatabase(
      "timer_app.db",
      version: 1,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  @override
  Future<void> createTable(Database db) async {
    await db.execute(
        "CREATE TABLE Timer (id INTEGER PRIMARY KEY, title TEXT, description TEXT, time_in_sec INTEGER)");
  }

  @override
  Future<int> insertData(Map<String, dynamic> data) async {
    return await _db.insert("Timer", data);
  }

  @override
  Future<List<Map>> getData() async {
    var data = await _db.rawQuery("SELECT * FROM Timer");
    return data;
  }

  @override
  Future<void> updateData(Map<String, dynamic> data) async {
    _db.update("Timer", data, where: "id = ?", whereArgs: [data['id']]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _db.delete("Timer", where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<void> closeDatabase() async {
    await _db.close();
  }
}