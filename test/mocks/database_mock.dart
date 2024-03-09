import 'package:sqflite_common/sqlite_api.dart';
import 'package:timer_app/database/db.dart';

class MockDatabase implements IDatabase {
  bool invokedCloseDatabase = false;
  int invokedCloseDatabaseCount = 0;
  @override
  Future<void> closeDatabase() async {
    invokedCloseDatabase = true;
    invokedCloseDatabaseCount++;
  }

  bool invokedCreateTable = false;
  int invokedCreateTableCount = 0;
  @override
  Future<void> createTable(Database db) async {
    invokedCreateTable = true;
    invokedCreateTableCount++;
  }

  bool invokedDeleteData = false;
  int invokedDeleteDataCount = 0;
  @override
  Future<void> deleteData(int id) async {
    invokedDeleteData = true;
    invokedDeleteDataCount++;
  }

  bool invokedGetData = false;
  int invokedGetDataCount = 0;
  List<Map> stubbedGetData = [];
  @override
  Future<List<Map>> getData() async {
    invokedGetData = true;
    invokedGetDataCount++;
    return stubbedGetData;
  }

  bool invokedInit = false;
  int invokedInitCount = 0;
  @override
  Future<void> init() async {
    invokedInit = true;
    invokedInitCount++;
  }

  bool invokedInsertData = false;
  int invokedInsertDataCount = 0;
  int stubbedInsertData = 0;
  @override
  Future<int> insertData(Map<String, dynamic> data) async {
    invokedInsertData = true;
    invokedInsertDataCount++;
    return stubbedInsertData;
  }

  bool invokedUpdateData = false;
  int invokedUpdateDataCount = 0;
  @override
  Future<void> updateData(Map<String, dynamic> data) async {
    invokedUpdateData = true;
    invokedUpdateDataCount++;
  }
}
