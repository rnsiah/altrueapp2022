import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final userTable = 'userTable';
final userOrder = 'userOrder';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database?> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "User.db");

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  deleteDabase() async {
    await deleteDabase();
  }

  void onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $userTable ("
        "id INTEGER PRIMARY KEY, "
        "email TEXT, "
        "key TEXT, "
        "altid INTEGER, "
        "hasProfile INTEGER "
        ")");

    // await database.execute("CREATE TABLE $userOrder ("
    //     "id INTEGER PRIMARY KEY, "
    //     "shirt TEXT, "
    //     "color TEXT, "
    //     "price INTEGER, "
    //     "quantity INTEGER "
    //     ")");
  }
}
