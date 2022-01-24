import 'package:mobile/Data_Layer/Models/user_model.dart';

import 'user_db.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db!.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> updateUserAfterProfileCreated(User user) async {
    final db = await dbProvider.database;
    var result = await db!.update(userTable, user.toDatabaseJson(),
        where: "id =?", whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db!.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<User?> getCurrentUser(int id) async {
    final db = await dbProvider.database;
    var result = await db!.query(userTable, where: "id=?", whereArgs: [id]);
    if (result.length > 0) {
      return new User.fromDatabaseJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> updateUser(User user) async {
    if (user.hasProfile == 1) {
      final db = await dbProvider.database;
     await (db!.rawUpdate('''
      UPDATE userTable
      SET hasProfile = ?
      WHERE _id = ?
    ''', [1, 0]));
    }
    
  }

  Future<int> checkIfProfileComplete(int altid) async {
    final db = await dbProvider.database;
    var res =
        await db!.query(userTable, where: 'altid = ?', whereArgs: [altid]);
    if (res.length > 0) {
      User user = new User.fromDatabaseJson(res.first);
      if (user.hasProfile == 1) {
        return 1;
      }
      return 0;
    } else
      return 0;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db!.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}
