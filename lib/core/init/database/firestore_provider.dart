import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/init/database/database_model.dart';

abstract class FirestoreProvider<T extends DatabaseModel> {
   CollectionReference<Map<String, dynamic>>? collectionReference;
void setCollectionReference(CollectionReference<Map<String, dynamic>> collectionReference);

  Future<T?> getItem(String id);
  Future<List<T>> getItemList();
  Future<bool> updateItem(int id,T model);
  Future<bool> removeItem(int id);
  Future<bool> insertItem(T model);
  Future<void> removeAllItems();
  Future<bool> isExist(T model);

}
