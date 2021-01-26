import 'dart:async';
import 'package:gknow/searchProfile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'favoriteUsers.dart';

class DbHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "favGit.db");
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Users(id INTEGER PRIMARY KEY, username TEXT, link TEXT)");
  }

  Future<List<User>> getUsers() async {
    var dbUser = await db;
    var result = await dbUser.query("Users", orderBy: "username");
    return result.map((data) => User.fromMap(data)).toList();
  }

  Future<List<User>> getHistory() async {
    var dbUser = await db;
    var result = await dbUser.query("History", orderBy: "username");
    return result.map((data) => User.fromMap(data)).toList();
  }

  Future<int> isAdded(String name) async {
    var dbUser = await db;
    List<Map> result =
        await dbUser.rawQuery("SELECT * FROM Users WHERE username=?", [name]);
    if (result.length > 0) {
      SearchProfile.isAdded = true;
    } else {}
  }

  Future<int> insertUser(User user) async {
    var dbUser = await db;
    List<Map> result = await dbUser
        .rawQuery("SELECT * FROM Users WHERE username=?", [user.username]);
    if (result.length > 0) {
    } else {
      return await dbUser.insert("Users", user.toMap());
    }
  }

  Future<void> removeUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete("Users", where: "id=?", whereArgs: [id]);
  }
}
