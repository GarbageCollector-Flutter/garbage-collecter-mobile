import 'package:cloud_firestore/cloud_firestore.dart';
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
      // ignore: curly_braces_in_flow_control_structures
      operationModel = OperationModel.fromJson(documentSnapshot.data()!);
    return operationModel;
  }

  @override
  Future<List<OperationModel>> getItemList() async {
    // ignore: non_constant_identifier_names
    List<OperationModel> OperationList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.docs.forEach((element) {
      OperationList.add(OperationModel.fromJson(element.data()));
    });
    return OperationList;
  }

  @override
  Future<bool> insertItem(OperationModel model) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await collectionReference.add(model.toJson());
      documentReference.update({"docId": documentReference.id});

      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return false;
    }
  }

  @override
  Future<bool> isExist(OperationModel model) {
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
  void setCollectionReference(
      CollectionReference<Map<String, dynamic>> collectionReference) {
    this.collectionReference = collectionReference;
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
