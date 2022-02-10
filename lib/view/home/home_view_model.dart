import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/constants/app/enums/app_theme_enum.dart';
import 'package:first_three/core/init/notifier/theme_notifier.dart';
import 'package:first_three/model/player/player_model.dart';
import 'package:first_three/model/player/player_model_provider.dart';
import 'package:first_three/model/tournament/tournament_firestore_provider.dart';
import 'package:first_three/model/tournament/tournament_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  BuildContext? context;
  PlayerModel? playerModel;
  PlayerModelProvider playerModelProvider = PlayerModelProvider();
  @observable
  List<TournamentModel> outDatedTournaments = [];
    @observable
  List<TournamentModel> continuingTournaments = [];
  TournamentFirestoreProvider tournamentFirestoreProvider =
      TournamentFirestoreProvider();

  Future<PlayerModel?> getPlayer() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('players');
    playerModelProvider.setCollectionReference(collectionReference);
    playerModel = await playerModelProvider.getCurrentUSer();
    return playerModel;
  }

  Future<void> getTournaments() async {
    for (String tournamentPath in playerModel!.tournaments!) {
      TournamentModel tournamentModel = await tournamentFirestoreProvider
          .getTournamentFromPAth(tournamentPath);
          if(isOutdated(tournamentModel.tournamentFinishTime!)){
              outDatedTournaments.add(tournamentModel);
          }else{
               continuingTournaments.add(tournamentModel);
          }
    }
  }

  void setContext(BuildContext context) async {
    this.context = context;
  }
}

bool isOutdated(int timeStamp) {
  DateTime now = DateTime.now();
  DateTime finishTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  if (finishTime.isBefore(now)) {
    return true;
  } else {
    return false;
  }
}
