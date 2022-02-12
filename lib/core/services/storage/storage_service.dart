// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StrageService{

final firebase_storage.Reference _storage =
  firebase_storage.FirebaseStorage.instance.ref();
  

  final DateTime time = DateTime.now();
 // String? resimId;

    Future<String> userimgUpload(File imageFile, String id) async {
      var randomName = getRandomString(10);
    
      print("randomname : ");
      print(randomName);

    firebase_storage.UploadTask uploadTask =
        _storage.child("images/userpictures/$id$randomName.jpg").putFile(imageFile);

    firebase_storage.TaskSnapshot snapshot = await uploadTask;

    String imageURL = await snapshot.ref.getDownloadURL();
    return imageURL;
  }

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

}

mixin FirebaseStorage {
}