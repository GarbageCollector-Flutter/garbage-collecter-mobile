import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
import 'package:first_three/core/init/database/firestore_provider.dart';
import 'package:first_three/model/operations/operation_model.dart';

class OperationModelProvider implements FirestoreProvider<OperationModel> {
  @override
  late CollectionReference<Map<String, dynamic>> collectionReference;

  @override
  Future<OperationModel?> getItem(String id) async {
    OperationModel? operationModel;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await collectionReference.doc(id).get();
    if (documentSnapshot.data() != null)
      operationModel = OperationModel.fromJson(documentSnapshot.data()!);
    return operationModel;
  }

  @override
  Future<List<OperationModel>> getItemList() async {
    List<OperationModel> OperationList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    querySnapshot.docs.forEach((element) {
      OperationList.add(OperationModel.fromJson(element.data()));
    });
    return OperationList;
  }

  @override
  Future<OperationModel?> insertItem(OperationModel model) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await collectionReference.add(model.toJson());
      documentReference.update({"docId": documentReference.id});
      model.docId = documentReference.id;
      return model;
    } catch (e) {

      return null;
    }
  }

  @override
  Future<bool> isExist(OperationModel model) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllItems() {
    throw UnimplementedError();
  }

  @override
  Future<bool> removeItem(int id) {
    throw UnimplementedError();
  }

  @override
  void setCollectionReference() {
    collectionReference = FirebaseFirestore.instance
        .collection(FirebaseConstants.OPERATIONS_PATH);
  }

  @override
  Future<bool> updateItem(String id, OperationModel model) async {
    try {
      await collectionReference.doc(id).update(model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
