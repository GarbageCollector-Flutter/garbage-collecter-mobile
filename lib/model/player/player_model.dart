import 'package:first_three/core/init/database/database_model.dart';

class PlayerModel extends DatabaseModel{
  String? name;
  String? phone;
  List<dynamic>? scores;
  String? palyerId;
  int? highScore;
  List<dynamic>? tournaments=[];

  PlayerModel(
      {this.name, this.phone, this.scores, this.palyerId, this.highScore});

  PlayerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    scores = json['scores'];
    palyerId = json['palyerId'];
    highScore = json['high_score'];
    tournaments = json['tournaments'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['scores'] =scores;
    data['palyerId'] = palyerId;
    data['high_score'] = highScore;
    data['tournaments'] = tournaments;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
