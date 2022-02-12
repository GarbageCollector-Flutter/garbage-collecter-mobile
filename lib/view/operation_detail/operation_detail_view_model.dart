import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/firebase/firebase_constatns.dart';
import 'package:first_three/model/officer/officer_model.dart';
import 'package:first_three/model/officer/officer_model_provider.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/model/operations/operation_model_provider.dart';
import 'package:first_three/model/user/user_model_provider.dart';
import 'package:first_three/model/user_officer/user_officer.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user/user_model.dart';
part 'operation_detail_view_model.g.dart';

class OperationDetailViewModel = _OperationDetailViewModelBase
    with _$OperationDetailViewModel;

abstract class _OperationDetailViewModelBase with Store {
  BuildContext? context;
  late String operationPath;

   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @observable
  OperationModel? operationModel;
  @observable
  UserModel? organizator;

@observable
var officers = ObservableList<UserOfficer>();

@observable
var garbage_collecters = ObservableList<UserModel>();




  OperationModelProvider operationModelProvider = OperationModelProvider();
  UserModelProvider userModelProvider = UserModelProvider();
  OfficerModelProvider officerModelProvider = OfficerModelProvider();

  void setContext(BuildContext context) async {
    this.context = context;
  }

  void setAllProvidersCollectionReference() {
    CollectionReference<Map<String, dynamic>>? collectionReference =
        FirebaseFirestore.instance
            .collection(FirebaseConstants.OPERATIONS_PATH);
    operationModelProvider.setCollectionReference(collectionReference);

    CollectionReference<Map<String, dynamic>>? collectionReference2 =
        FirebaseFirestore.instance.collection(FirebaseConstants.USERS_PATH);
    userModelProvider.setCollectionReference(collectionReference2);
  }

  void setOfficerPath() {
    CollectionReference<Map<String, dynamic>>? collectionReference =
        FirebaseFirestore.instance
            .collection(FirebaseConstants.OPERATIONS_PATH)
            .doc(operationModel!.docId)
            .collection(FirebaseConstants.OFFICERS_PATH);
    officerModelProvider.setCollectionReference(collectionReference);
  }

  Future<void> getOperation() async {
    operationModel = await operationModelProvider.getItem(operationPath);
    organizator = await userModelProvider.getItem(operationModel!.organizator);
   await getCollecters();
   
   await getOfficers();
  }

  Future<void> getCollecters() async {
     garbage_collecters.clear();
    for (dynamic item in operationModel!.garbageCollecters) {
      UserModel? collecter = await userModelProvider.getItem(item);
      if (collecter != null) {
        garbage_collecters.add(collecter);
      }
    }
  }

  Future<void> getOfficers() async {
    setOfficerPath();
    List<OfficerModel> officerModels = [];
    officerModels = await officerModelProvider.getItemList();
    for (OfficerModel officerModel in officerModels) {
      UserModel? userModel =
          await userModelProvider.getItem(officerModel.userId);
      if (userModel != null) {
        UserOfficer userOfficer =
            UserOfficer(officerModel: officerModel, usermodel: userModel);
        officers.add(userOfficer);      }
    }
    return;
  }
  void addPhoto(){

  }
 Future <void> addCollecter()async{
     final SharedPreferences prefs = await _prefs;
    String? userId=  prefs.getString('currentUserPhone');
    if(userId!=null){
      if(operationModel!=null){
    operationModel!.garbageCollecters.add(userId);
   await  operationModelProvider.updateItem(operationModel!.docId, operationModel!);
      }

    }
  }
}
