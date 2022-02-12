import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/model/operations/operation_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'officier_form_view_model.g.dart';

class OfficierFormViewModel = _OfficierFormViewModelBase with _$OfficierFormViewModel;

abstract class _OfficierFormViewModelBase with Store {
  BuildContext? context;
  late OperationModel operationModel;

  OperationModelProvider operationModelProvider = OperationModelProvider();



  void setContext(BuildContext context) async {
    this.context = context;

  }

}
