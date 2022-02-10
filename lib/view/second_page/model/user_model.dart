import 'package:first_three/core/init/database/database_model.dart';

class UserModel extends DatabaseModel {
  String? userName;
  int? age;
  int? isMarried;
 

  UserModel({this.userName, this.age, this.isMarried});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    age = json['age'];
    isMarried = json['isMarried'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = userName;
    data['age'] = age;
    data['isMarried'] = isMarried;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}