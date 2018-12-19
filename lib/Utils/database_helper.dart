import 'dart:io';

import 'package:database_intro_android/Models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableUser = "userTable";
  final String columnID = "id";
  final String columnUserame = "username";
  final String columnPassword = "password";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "maindb.db"); // home://directory/files/maidb.db

    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);

    return ourDB;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableUser($columnID INTEGER PRIMARY KEY, $columnUserame TEXT, $columnPassword TEXT)");
  }

  // CRUD - CREATE READ UPDATE DELETE

  //Insert
  Future<int> saveUser(User user) async {
    var dbClient = await db;

    int res = await dbClient.insert("$tableUser", user.toMap());

    return res;
  }

  //get users
  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT $columnID, $columnUserame, $columnPassword from $tableUser");
    return result.toList();
  }

  //get count registers
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
  }

  // get one user *register
  Future<User> getUser(int id) async {
    var dbClient = await db;
    //User user;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableUser WHERE $columnID = $id");

    if (result.isEmpty) {
      return User("Não encontrado.","");
    } else {
      return User.fromMap(result.first);
    }
  }

  // delete user
  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: "$columnID =?", whereArgs: [id]);
  }

  // update user
  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient
        .update(tableUser, user.toMap(), where: columnID, whereArgs: [user.id]);
  }

  //Close
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
