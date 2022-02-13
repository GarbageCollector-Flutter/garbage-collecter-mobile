import 'package:first_three/core/init/database/database_model.dart';

class OperationModel extends DatabaseModel {
  late String docId;
  late String operationName;
  late String organizator;
  late String location;
  late int operationStart;
  late List<dynamic> garbageCollecters;
  late List<dynamic> beforePhoto;
  late List<dynamic> afterPhoto;

  OperationModel(
      {required this.operationName,
      required this.organizator,
      required this.location,
      required this.operationStart,
      required this.garbageCollecters,
      required this.beforePhoto,
      required this.afterPhoto,
      required this.docId});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
     data['docId'] = docId;
    data['operation_name'] = operationName;
    data['organizator'] = organizator;
    data['location'] = location;
    data['operation_start'] = operationStart;
    data['garbage_collecters'] = garbageCollecters;
    data['before_photo'] = beforePhoto;
    data['after_photo'] = afterPhoto;
    return data;
  }

  @override
  OperationModel.fromJson(Map<String, dynamic> json) {
     docId = json['docId'];
    operationName = json['operation_name'];
    organizator = json['organizator'];
    location = json['location'];
    operationStart = json['operation_start'];
    garbageCollecters = json['garbage_collecters'];
    beforePhoto = json['before_photo'];
    afterPhoto = json['after_photo'];
  }

  @override
  fromJson(Map<String, dynamic> json) {
    
    throw UnimplementedError();
  }
}
