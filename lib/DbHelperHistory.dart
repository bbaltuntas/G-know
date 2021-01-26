import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'favoriteUsers.dart';

class DbHelperHistory {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "hisGit.db");
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE History(id INTEGER PRIMARY KEY, username TEXT, link TEXT)");
  }

  Future<List<User>> getHistory() async {
    var dbUser = await db;
    var result = await dbUser.query("History", orderBy: "username");
    return result.map((data) => User.fromMap(data)).toList();
  }

  Future<void> removeAll() async {
    var dbClient = await db;
    return await dbClient.delete("History");
  }

  Future<int> insertHistory(User user) async {
    var dbUser = await db;
    List<Map> result = await dbUser
        .rawQuery("SELECT * FROM History WHERE username=?", [user.username]);
    if (result.length > 0) {
    } else {
      return await dbUser.insert("History", user.toMap());
    }
  }
}
