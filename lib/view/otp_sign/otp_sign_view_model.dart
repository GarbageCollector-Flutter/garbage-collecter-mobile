import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_three/core/init/authentication/authentication_provider.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'otp_sign_view_model.g.dart';

class OtpSignViewModel = _OtpSignViewModelBase with _$OtpSignViewModel;

abstract class _OtpSignViewModelBase with Store {
  @observable
  String? smsCode;
  PhoneAuthCredential? phoneAuthCredential;
  BuildContext? context;
  String? verificationId;
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Auth auth = Auth();
  late UserModel userModel;

  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> phoneVerification() async {
    final SharedPreferences prefs = await _prefs;
      await prefs.setString('currentUserPhone', userModel.phone);
    await auth.phoneSignIn(
     
        onSms: smsCodeSet,
        onverificationId: verificationIdSet, userModel: userModel);
  }

  @action
  void smsCodeSet(PhoneAuthCredential phoneAuthCredential) {
    this.phoneAuthCredential = phoneAuthCredential;
    smsCode = phoneAuthCredential.smsCode;
    // ignore: avoid_print
    print("---------------smscode" + smsCode.toString());
  }

  void verificationIdSet(String verificationId, int? _) {
    this.verificationId = verificationId;
  }

  Future<void> completeAutoLogin() async {
    await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential!);
    phoneAuthCredential = null;
    Navigator.pop(context!);
  }

  Future<void> manuelLogin(String smsCode) async{
    if (verificationId != null) {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode);
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      Navigator.pop(context!);
    }
  }
}
