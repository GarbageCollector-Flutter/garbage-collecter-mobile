
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/model/operations/operation_model_provider.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/model/user/user_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'operation_form_view_model.g.dart';

class OperationFormViewModel = _OperationFormViewModelBase
    with _$OperationFormViewModel;

abstract class _OperationFormViewModelBase with Store {
  late BuildContext context;
  late String userId;
  DateTime startTime = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  OperationModelProvider operationModelProvider = OperationModelProvider();
  UserModelProvider userModelProvider = UserModelProvider();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @observable
  List<OperationModel> outDatedOpertaions = [];
  @observable
  List<OperationModel> continuingOpertaions = [];

  void setContext(BuildContext context) async {
    this.context = context;
  }

  bool validateForm() {
    if (nameController.text != "" &&
        // ignore: unrelated_type_equality_checks
        locationController != "" &&
        startTime.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }
  OperationModel createOperationModel() {
    OperationModel operationModel = OperationModel(
        afterPhoto: [],
        beforePhoto: [],
        docId: '',
        garbageCollecters: [],
        location: locationController.text,
        operationName: nameController.text,
        operationStart: startTime.millisecondsSinceEpoch,
        organizator: userId);
    return operationModel;
  }

  Future<bool> createOperation() async {
    if (validateForm()) {
      OperationModel? operationModel = createOperationModel();
      operationModel = await operationModelProvider.insertItem(operationModel);
      UserModel? userModel = await getCurrentUser();
      if (userModel != null && operationModel != null) {
           

        userModel.joinedOperations.add(operationModel.docId);
        return await userModelProvider.updateItem(userModel.phone, userModel);
        
      }
    }
    return false;
  }

  Future<UserModel?> getCurrentUser() async {
    final SharedPreferences prefs = await _prefs;
    String? userId = prefs.getString('currentUserPhone');
    if (userId != null) {
      return await userModelProvider.getItem(userId);
    } else {
      return null;
    }
  }
}
