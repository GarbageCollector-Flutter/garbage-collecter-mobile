import 'package:first_three/model/player/player_model.dart';
import 'package:first_three/model/tournament/tournament_firestore_provider.dart';
import 'package:first_three/model/tournament/tournament_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'rank_table_view_model.g.dart';

class RankTableViewModel = _RankTableViewModel with _$RankTableViewModel;

  BuildContext? context;
  String? tournamentPath;
  TournamentFirestoreProvider tournamentFirestoreProvider =
      TournamentFirestoreProvider();
  @observable
  TournamentModel? tournamentModel;
  @observable
  List<PlayerModel> ranks = [];

  void setContext(BuildContext context) async {
    this.context = context;
  }

  void getTournament() async {
    tournamentModel = await tournamentFirestoreProvider
        .getTournamentFromPAth(tournamentPath!);
  }

  Future<void> getRanks() async {
    List<PlayerModel> tempList = await tournamentFirestoreProvider
        .getTournamentRanksFromPAth(tournamentPath! + "/players");
    tempList.sort((a, b) => b.highScore != null
        ? b.highScore!.compareTo(a.highScore!)
        : b.highScore = 0);
    ranks = tempList;
  }
}
