import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
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
    throw UnimplementedError();
  }

  @override
  Future<UserModel> insertItem(UserModel model) async {
    try {
      await collectionReference.doc(model.phone).set(model.toJson());
      return model;
    } catch (e) {
      return model;
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
   
    throw UnimplementedError();
  }

  @override
  Future<bool> removeItem(int id) {
   
    throw UnimplementedError();
  }

  @override
  void setCollectionReference() {
      collectionReference = FirebaseFirestore.instance
        .collection(FirebaseConstants.USERS_PATH);
  }

  @override
  Future<bool> updateItem(String id, UserModel model)async {
       try {
      await collectionReference.doc(id).update(model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
