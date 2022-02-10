import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/init/database/database_provider.dart';
import 'package:first_three/model/player/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../core/init/database/firestore_provider.dart';

class PlayerModelProvider implements FirestoreProvider<PlayerModel> {
  @override
  CollectionReference<Map<String, dynamic>>? collectionReference;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void setCollectionReference(
      CollectionReference<Map<String, dynamic>> collectionReference) {
    this.collectionReference = collectionReference;
  }

  @override
  Future<PlayerModel?> getItem(String id) async{

 DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await collectionReference!.doc(id).get();
 PlayerModel? playerModel;
  if(documentSnapshot.data()!=null){
  playerModel = PlayerModel.fromJson(documentSnapshot.data()!);
  playerModel.palyerId = documentSnapshot.id;
  }
  return playerModel;
  }
  
  Future<PlayerModel?> getCurrentUSer() async{
    final SharedPreferences prefs = await _prefs;
    final String? userPhone = prefs.getString('currentUserPhone');
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await collectionReference!.doc(userPhone).get();
    PlayerModel playerModel = PlayerModel.fromJson(documentSnapshot.data()!);
    return playerModel;
  }

  @override
  Future<List<PlayerModel>> getItemList() {
    // TODO: implement getItemList
    throw UnimplementedError();
  }

  @override
  Future<bool> insertItem(PlayerModel model) async {
    print("-------------------------------------object" +
        collectionReference!.path.toString());

    try {
      await collectionReference!
          .doc(model.phone)
          .set(model.toJson())
          .onError((error, stackTrace) =>
              (print("-----------------" + stackTrace.toString())))
          .then(
              (value) => print("------------------------------------başarılı"));
      print("-------------------------------------object");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isExist(PlayerModel model) async {
    print("-------------------------------------object" +
        collectionReference!.path.toString());

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await collectionReference!.doc(model.phone).get();
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> removeAllItems() {
    // TODO: implement removeAllItems
    throw UnimplementedError();
  }

  @override
  Future<bool> removeItem(int id) {
    // TODO: implement removeItem
    throw UnimplementedError();
  }

  @override
  Future<bool> updateItem(int id, PlayerModel model) {
    // TODO: implement removeItem
    throw UnimplementedError();
  }

  Future<void> addNewScore(PlayerModel model, int newScore) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await collectionReference!.doc(model.phone).get();
    if (documentSnapshot.data() != null) {
      Map<String, dynamic> playerJson = documentSnapshot.data()!;
      PlayerModel playerModel = PlayerModel.fromJson(playerJson);
        
      if (playerModel.scores != null) {
        playerModel.scores!.add(newScore);
        if(playerModel.highScore==null){
          playerModel.highScore=0;
        }
              
        for (int score in playerModel.scores!) {
          if (score >= playerModel.highScore!) {
            playerModel.highScore = score;
          }
        }
      } else {
        playerModel.scores = [newScore];
        playerModel.highScore = newScore;
      }

      collectionReference!.doc(model.phone).update(playerModel.toJson());
    } else {
      throw "bir hata oluştu";
    }
  }
}
