import 'package:first_three/core/init/database/database_model.dart';
import 'package:first_three/core/init/database/database_provider.dart';
import 'package:first_three/view/second_page/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDataBaseProvider implements DatabaseProvider<UserModel> {
  @override
  Database? database;
  final int version = 1;
  final String _userDatabaseName = "advancedSqflite";
  final String _userTableName = "users";

  // table' s columns names
  final String _columnId = "id";
  final String _columnUserName = "name";
  final String _columnUserAge = "age";
  final String _columnIsMarried = "isMarried";

  @override
  Future<void> open() async {
    database = await openDatabase(_userDatabaseName, version: version,
        onCreate: (db, version) {
      db.execute('''CREATE TABLE $_userTableName 
          ( $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnUserName VARCHAR(20),
            $_columnUserAge INTEGER ,
            $_columnIsMarried INTEGER )''');
    });
  }

  @override
  Future<List<UserModel>> getItemList() async {
    if(database==null){
      await open();
    }
    List<Map<String, dynamic>> userMap = await database!.query(_userTableName);
    return userMap.map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserModel?> getItem(int id) async {
    
    if(database==null){
      await open();
    }
    List<Map<String, dynamic>> userMap = await database!.query(_userTableName,
        where: '$_columnId = ?', columns: [_columnId], whereArgs: [id]);
    if (userMap.isNotEmpty) {
      return UserModel.fromJson(userMap.elementAt(0));
    } else {
      return null;
    }
  }

  @override
  Future<bool> removeItem(int id) async {
    final int totalAffected = await database!
        .delete(_userTableName, where: '$_columnId = ?', whereArgs: [id]);
    if (totalAffected >= 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> insertItem(UserModel userModel) async {
    final int isOk = await database!.insert(_userTableName, userModel.toJson());
    if (isOk >= 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateItem(int id, UserModel model) async {
    final int isOk = await database!.update(_userTableName, model.toJson(),
        where: '$_columnId = ?', whereArgs: [id]);
    if (isOk >= 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() async {
    await database!.close();
  }

  @override
  Future<void> removeAllItems() async {
    // ignore: unused_local_variable
    final int totalAffected = await database!.delete(_userTableName);
  }




}
