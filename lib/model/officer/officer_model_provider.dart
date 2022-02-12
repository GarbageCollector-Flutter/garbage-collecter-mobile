import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/init/database/firestore_provider.dart';
import 'package:first_three/model/officer/officer_model.dart';

class OfficerModelProvider implements FirestoreProvider<OfficerModel> {
  @override
  late CollectionReference<Map<String, dynamic>> collectionReference;

  @override
  Future<OfficerModel?> getItem(String id) {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  Future<List<OfficerModel>> getItemList()async {
    List<OfficerModel> officerList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    querySnapshot.docs.forEach((element) {
      officerList.add(OfficerModel.fromJson(element.data()));
    });
    return officerList;
  }

  @override
  Future<OfficerModel> insertItem(OfficerModel model) {
    // TODO: implement insertItem
    throw UnimplementedError();
  }

  @override
  Future<bool> isExist(OfficerModel model) {
    // TODO: implement isExist
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllItems() {
    // TODO: implement removeAllItems
    throw UnimplementedError();
  }

  @override
  Future<bool> removeItem(int id) {
    // TODO: implement removeItem
    throw UnimplementedError();
  }

  @override
  void setCollectionReference() {

  }
   void setSpecificCollectionReference(CollectionReference<Map<String, dynamic>> collectionReference) {
    this.collectionReference = collectionReference;
  }

  @override
  Future<bool> updateItem(String id, OfficerModel model) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  
}