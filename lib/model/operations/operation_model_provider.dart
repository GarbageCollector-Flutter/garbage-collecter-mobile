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
  Future<bool> insertItem(OperationModel model)async {
       try {
       DocumentReference<Map<String, dynamic>> documentReference= await collectionReference.add(model.toJson());
       documentReference.update({"docId":documentReference.id});
  
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<bool> isExist(OperationModel model) {
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
  void setCollectionReference(
      CollectionReference<Map<String, dynamic>> collectionReference) {
    this.collectionReference = collectionReference;
  }

  @override
  Future<bool> updateItem(int id, OperationModel model) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}
