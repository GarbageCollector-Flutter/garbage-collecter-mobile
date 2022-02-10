import 'package:first_three/core/init/database/database_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider<T extends DatabaseModel> {
  Database? database;

  Future open();
  Future<T?> getItem(int id);
  Future<List<T>> getItemList();
  Future<bool> updateItem(int id,T model);
  Future<bool> removeItem(int id);
  Future<bool> insertItem(T model);
  Future<void> removeAllItems();
  Future<void> close() async {
    if (database != null) {
      await database!.close();
    }
  }
}
