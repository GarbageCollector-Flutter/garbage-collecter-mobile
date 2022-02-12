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
 DateTime startTime =DateTime.now();
 TextEditingController nameController = TextEditingController();
 TextEditingController locationController = TextEditingController();
 OperationModelProvider operationModelProvider = OperationModelProvider();

 
  @observable
  List<OperationModel> outDatedOpertaions = [];
  @observable
  List<OperationModel> continuingOpertaions = [];

  void setContext(BuildContext context) async {
    this.context = context;
  }
  
  bool validateForm(){
    if(nameController.text!=""&&locationController!=""&&startTime.isAfter(DateTime.now())){
      return true;
    }else{
      return false;
    }
  }

  void setOperationProviderPath(){
       CollectionReference<Map<String, dynamic>>? collectionReference =
        FirebaseFirestore.instance
            .collection(FirebaseConstants.OPERATIONS_PATH);
      operationModelProvider.setCollectionReference(collectionReference);
  }


  OperationModel createOperationModel(){
    OperationModel operationModel = OperationModel(afterPhoto: [], beforePhoto: [], docId: '', garbageCollecters: [], location: locationController.text, operationName: nameController.text, operationStart: startTime.millisecondsSinceEpoch, organizator: userId);
   return operationModel;
  }

  Future<bool> createOperation()async{
  if(validateForm()){
   OperationModel operationModel =  createOperationModel();

  return await operationModelProvider.insertItem(operationModel);

  }
  else{
   return false;
  }

  }

}
