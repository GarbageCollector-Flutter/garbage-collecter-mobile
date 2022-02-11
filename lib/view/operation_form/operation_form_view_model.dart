import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/model/operations/operation_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'operation_form_view_model.g.dart';

class OperationFormViewModel = _OperationFormViewModelBase with _$OperationFormViewModel;

abstract class _OperationFormViewModelBase with Store {
 late BuildContext context;
 late String userId;
 DateTime? startTime;
 TextEditingController nameController = TextEditingController();
 TextEditingController locationController = TextEditingController();

 
  @observable
  List<OperationModel> outDatedOpertaions = [];
  @observable
  List<OperationModel> continuingOpertaions = [];

  void setContext(BuildContext context) async {
    this.context = context;
  }

}
