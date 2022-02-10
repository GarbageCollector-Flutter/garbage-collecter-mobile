import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/init/navigation/navigation_service.dart';
import 'package:first_three/model/player/player_model.dart';
import 'package:first_three/model/player/player_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../second_page/model/user_model.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  BuildContext? context;

  TextEditingController phoneNumberLogin = TextEditingController(text: "+90");
  TextEditingController phoneNumberRegister =
      TextEditingController(text: "+90");
  TextEditingController nameController = TextEditingController();

  PlayerModelProvider userFirestoreProvider = PlayerModelProvider();

  void setContext(BuildContext context) {
    this.context = context;
      CollectionReference<Map<String, dynamic>>  collectionReference= FirebaseFirestore
        .instance
        .collection('players');
      
    userFirestoreProvider.setCollectionReference(collectionReference);
  }

  Future<bool> registerRequest(PlayerModel playerModel) async {
    if (await userFirestoreProvider.isExist(playerModel)) {
      throw ("bu numaraya ait kayıt mevcut lütfen giriş yapınız");
    }
    return await userFirestoreProvider.insertItem(playerModel);
  }

  phoneNumberValidator() {
    //TODO
    // login veya register request kısmında hata döndür view de try catch ile yakala d,alog ekranı hazır.
  }

  Future<void> loginRequest(PlayerModel playerModel) async {
    if (!(await userFirestoreProvider.isExist(playerModel))) {
      throw ("bu numaraya ait kayıtlı üyemiz bulunmamaktadır lütfen kaydolun");
    }
    NavigationService.instance.navigateToPage(
        path: NavigationConstants.OTP_SIGN,
        data: PlayerModel(phone: playerModel.phone));
  }

  @observable
  int number = 0;

  @action
  void increment() {
    number++;
  }
}
