import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
import 'package:first_three/core/init/database/firestore_provider.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/model/operations/operation_model_provider.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/model/user/user_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  late BuildContext context;
  late String userId;

  UserModelProvider userModelProvider = UserModelProvider();
  OperationModelProvider operationModelProvider = OperationModelProvider();

  @observable
  UserModel? userModel;
  @observable
  var operations = ObservableList<OperationModel>();

  void setContext(BuildContext context) async {
    this.context = context;
  }
  Future<void> getUser() async {
    userModel = await userModelProvider.getItem(userId);
    if (userModel != null) {
      getUserOperations();
    }
  }

  Future<void> getUserOperations() async {
    operations.clear();
    for (String operationId in userModel!.joinedOperations) {
      OperationModel? operationModel =
          await operationModelProvider.getItem(operationId);
      if (operationModel != null) {
        operations.add(operationModel);
      }
    }
  }
}
