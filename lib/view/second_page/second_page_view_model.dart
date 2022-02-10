import 'package:first_three/view/home/home_view_model.dart';
import 'package:first_three/view/second_page/model/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'second_page_view_model.g.dart';

class SecondPageViewModel = _SecondPageViewModel with _$SecondPageViewModel;

abstract class _SecondPageViewModel with Store {
  UserDataBaseProvider userDataBaseProvider = UserDataBaseProvider();
  BuildContext? context;

  void setContext(BuildContext context) {
    this.context = context;
  }
}
