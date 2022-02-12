import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/init/database/firestore_provider.dart';
import 'package:first_three/model/officer/officer_model.dart';

class OfficerModelProvider implements FirestoreProvider<OfficerModel> {
  @override
  late CollectionReference<Map<String, dynamic>> collectionReference;

  @override
  Future<OfficerModel?> getItem(String id) {
    // ignore: todo
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  Future<List<OfficerModel>> getItemList()async {
    List<OfficerModel> officerList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.docs.forEach((element) {
      officerList.add(OfficerModel.fromJson(element.data()));
    });
    return officerList;
  }

  @override
  Future<bool> insertItem(OfficerModel model) {
    // ignore: todo
    // TODO: implement insertItem
    throw UnimplementedError();
  }

  @override
  Future<bool> isExist(OfficerModel model) {
    // ignore: todo
    // TODO: implement isExist
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllItems() {
    // ignore: todo
    // TODO: implement removeAllItems
    throw UnimplementedError();
  }

  @override
  Future<bool> removeItem(int id) {
    // ignore: todo
    // TODO: implement removeItem
    throw UnimplementedError();
  }

  @override
  void setCollectionReference(CollectionReference<Map<String, dynamic>> collectionReference) {
    this.collectionReference = collectionReference;
  }

  @override
  Future<bool> updateItem(String id, OfficerModel model) {
    // ignore: todo
    // TODO: implement updateItem
    throw UnimplementedError();
  }
  
}