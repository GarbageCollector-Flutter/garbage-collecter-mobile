import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/model/operations/operation_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  BuildContext? context;

  OperationModelProvider operationModelProvider = OperationModelProvider();

  @observable
  List<OperationModel> outDatedOpertaions = [];
  @observable
  List<OperationModel> continuingOpertaions = [];

  void setContext(BuildContext context) async {
    this.context = context;
    CollectionReference<Map<String, dynamic>>? collectionReference =
        FirebaseFirestore.instance
            .collection(FirebaseConstants.OPERATIONS_PATH);
    operationModelProvider.setCollectionReference(collectionReference);
  }


  Future<void> getAllOperations() async {
    continuingOpertaions=   await operationModelProvider.getItemList();

  }
}
