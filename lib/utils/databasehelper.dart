import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:userapp/models.dart/person.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String userTable = 'user_table';
  String id = 'id';
  String first_name = 'first_name';
  String last_name = 'last_name';
  String email = 'email';

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'user.db';

    var userDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $first_name TEXT, $last_name TEXT, $email)');
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.query(userTable);
    return result;
  }
//Inserting data
  Future<int> insertUser(Person user) async {
    Database db = await this.database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  //deleting data
  Future<int> deleteuser(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $userTable WHERE $id = $id');
    return result;
  }
}
