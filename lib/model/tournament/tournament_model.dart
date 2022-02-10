import 'package:first_three/core/init/database/database_model.dart';

class TournamentModel extends DatabaseModel {
  int? gameDuration;
  int? tournamentStartTime;
  int? tournamentFinishTime;
  String? gameMode;
  String? reward;
  String? price;
  String? gameName;
  String? id;

  TournamentModel(
      {this.gameDuration,
      this.tournamentStartTime,
      this.tournamentFinishTime,
      this.gameMode,
      this.reward,
      this.price,
      this.gameName,
      this.id});

  TournamentModel.fromJson(Map<String, dynamic> json) {
    gameDuration = json['gameDuration'];
    tournamentStartTime = json['tournamentStartTime'];
    tournamentFinishTime = json['tournamentFinishTime'];
    gameMode = json['gameMode'];
    reward = json['reward'];
    price = json['price'];
    gameName = json['gameName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['gameDuration'] = gameDuration;
    data['tournamentStartTime'] = tournamentStartTime;
    data['tournamentFinishTime'] = tournamentFinishTime;
    data['gameMode'] = gameMode;
    data['reward'] = reward;
    data['price'] = price;
    data['gameName'] = gameName;
    data['id'] = id;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
