import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
import 'package:first_three/model/officer/officer_model.dart';
import 'package:first_three/model/officer/officer_model_provider.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/model/operations/operation_model_provider.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/model/user/user_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_three/core/extenstions/string_extension.dart';

part 'officier_form_view_model.g.dart';



class OfficierFormViewModel = _OfficierFormViewModelBase
    with _$OfficierFormViewModel;

abstract class _OfficierFormViewModelBase with Store {
  BuildContext? context;
  late OperationModel operationModel;
  UserModel? userModel;
  OfficerModel? officerModel;

  OperationModelProvider operationModelProvider = OperationModelProvider();
  OfficerModelProvider officerModelProvider = OfficerModelProvider();
  UserModelProvider userModelProvider = UserModelProvider();

  final List<TextEditingController> controllers = [];
  final List<TextField> fields = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setContext(BuildContext context) async {
    this.context = context;
  }

  bool validateForm() {

    if (userModel != null) {
      officerModel =
          OfficerModel(userId: userModel!.phone, responsibilities: []);
      controllers.forEach((element) {
        if (element.text != "") {
          officerModel!.responsibilities.add(element.text);
        }
      });
      if (officerModel!.responsibilities.isEmpty) {
        "lütfen alanları doldurunuz".snackBarExtension(context!);
        return false;
      } else {
        return true;
      }
    } else {
       "lütfen internet bağlantınız kontrol edin".snackBarExtension(context!);
      return false;
    }
  }

  void setOfficerCollectionRef(){
    CollectionReference<Map<String, dynamic>> collectionReference=
    FirebaseFirestore.instance.collection(FirebaseConstants.OPERATIONS_PATH).doc(operationModel.docId).collection("officer");
   officerModelProvider.setSpecificCollectionReference(collectionReference);
  }
  Future<bool> saveChanges()async{
   if(validateForm()){
    await  officerModelProvider.insertItem(officerModel!);
    if(userModel!=null){
     if( userModel!.joinedOperations.contains(operationModel.docId)){
       return true;
     }else{
       userModel!.joinedOperations.add(operationModel.docId);
      await userModelProvider.updateItem(userModel!.phone, userModel!);
      return true;
     }
    }
   }
   return false;

  }

  Future<void> getCurrentUser() async {
    final SharedPreferences prefs = await _prefs;
    String? userId = prefs.getString('currentUserPhone');
    if (userId != null) {

      userModel = await userModelProvider.getItem(userId);
    }
  }
}
