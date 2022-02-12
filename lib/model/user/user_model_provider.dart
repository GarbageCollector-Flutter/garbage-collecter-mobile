import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/init/database/firestore_provider.dart';
import 'package:first_three/model/user/user_model.dart';

class UserModelProvider implements FirestoreProvider<UserModel> {
  @override
  late CollectionReference<Map<String, dynamic>> collectionReference;

  @override
  Future<UserModel?> getItem(String id) async {
    UserModel? userModel;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await collectionReference.doc(id).get();
    if (documentSnapshot.data() != null)
      userModel = UserModel.fromJson(documentSnapshot.data()!);
    return userModel;
  }

  @override
  Future<List<UserModel>> getItemList() {
    // TODO: implement getItemList
    throw UnimplementedError();
  }

  @override
  Future<bool> insertItem(UserModel model) async {
    try {
      await collectionReference.doc(model.phone).set(model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isExist(UserModel model) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await collectionReference.doc(model.phone).get();
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
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
  Future<bool> updateItem(String id, UserModel model) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}
