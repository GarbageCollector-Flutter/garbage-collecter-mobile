import 'package:first_three/core/init/database/database_model.dart';

class OfficerModel extends DatabaseModel  {
  late String userId;
  late List<String> responsibilities;

  OfficerModel({required this.userId, required this.responsibilities});

  OfficerModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    responsibilities = json['responsibilities'].cast<String>();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['responsibilities'] = responsibilities;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}