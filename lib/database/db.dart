import 'package:sqflite/sqflite.dart';

abstract class IDatabase {
  Future<void> createTable();
}

class TimerDatabase {
  late Database _db;

  void init() async {
    _db = await openDatabase(
      "timer_app.db",
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  void createTable(Database db) {
    db.execute(
        "CREATE TABLE Timer (id INTEGER PRIMARY KEY, title TEXT, description TEXT, time_in_sec INTEGER)");
  }

  void insertTimer(Map<String, dynamic> data) async {
    _db.insert("Timer", data);
  }

  void updateTimer(Map<String, dynamic> data) async {
    _db.update("Timer", data);
  }

  void deleteTimer(int id) {
    _db.delete("Timer", where: "id = ?", whereArgs: [id]);
  }

  void closeDatabase() {
    _db.close();
  }
}
