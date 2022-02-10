import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/app/enums/app_theme_enum.dart';
import 'package:first_three/core/init/notifier/theme_notifier.dart';
import 'package:first_three/model/player/player_model.dart';
import 'package:first_three/model/player/player_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  BuildContext? context;
  late PlayerModel playerModel;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  PlayerModelProvider playerModelProvider = PlayerModelProvider();

  void setContext(BuildContext context) async {
    this.context = context;
    final SharedPreferences prefs = await _prefs;
    final String? userPhone = prefs.getString('currentUserPhone');
    print("playerName********************"+userPhone.toString());
    playerModel = PlayerModel(phone: userPhone);
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('players');
    playerModelProvider.setCollectionReference(collectionReference);
  }

  Future<PlayerModel?> getPlayer() async {
if(playerModelProvider.collectionReference==null){
  await  Future.delayed(Duration(milliseconds: 200));
  return await playerModelProvider.getItem(playerModel.phone!);
}
    return await playerModelProvider.getItem(playerModel.phone!);
  }
}
