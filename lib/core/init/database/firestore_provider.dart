import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/init/database/database_model.dart';

abstract class FirestoreProvider<T extends DatabaseModel> {
 late  CollectionReference<Map<String, dynamic>> collectionReference;
void setCollectionReference();

  Future<T?> getItem(String id);
  Future<List<T>> getItemList();
  Future<bool> updateItem(String id,T model);
  Future<bool> removeItem(int id);
  Future<T?> insertItem(T model);
  Future<void> removeAllItems();
  Future<bool> isExist(T model);

}
