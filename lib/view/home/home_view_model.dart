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
  ObservableList<OperationModel> outDatedOpertaions = ObservableList<OperationModel>();
  @observable
  ObservableList<OperationModel> continuingOpertaions = ObservableList<OperationModel>();

  void setContext(BuildContext context) async {
    this.context = context;
    operationModelProvider.setCollectionReference();
  }
    @action
  Future<void> getAllOperations() async {
    List<OperationModel> allOperations = [];
    continuingOpertaions.clear();
    outDatedOpertaions.clear();

    allOperations = await operationModelProvider.getItemList();
    for (OperationModel operationModel in allOperations) {
      DateTime dateStart =
          DateTime.fromMillisecondsSinceEpoch(operationModel.operationStart);
      if (dateStart.isAfter(DateTime.now())) {
        continuingOpertaions.add(operationModel);
      } else {
        outDatedOpertaions.add(operationModel);
      }
    }
    //return;
  }
}
