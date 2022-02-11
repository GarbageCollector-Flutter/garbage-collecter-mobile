import 'package:first_three/core/init/database/database_model.dart';

class UserModel  extends DatabaseModel{
  late String name;
  late String phone;
  late List<String> joinedOperations;

  UserModel({required this.name,required this.phone,required this.joinedOperations});


   @override
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    joinedOperations = json['joined_operations'].cast<String>();
  }

  @override
  fromJson(Map<String, dynamic> json) {
     name = json['name'];
    phone = json['phone'];
    joinedOperations = json['joined_operations'].cast<String>();
  }


  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['joined_operations'] = joinedOperations;
    return data;
  }


}
