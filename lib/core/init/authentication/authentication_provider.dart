


import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_three/model/player/player_model.dart';

class Auth {



 
  PhoneAuthCredential? phoneAuthCredential;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Auth();


  Future<PhoneAuthCredential?> phoneSignIn({required PlayerModel playerModel,required dynamic onSms,required dynamic onverificationId}) async {

    await _auth.verifyPhoneNumber(
        phoneNumber: playerModel.phone!,
        verificationCompleted:onSms,
        verificationFailed: _onVerificationFailed,
        codeSent: onverificationId,
        codeAutoRetrievalTimeout: _onCodeTimeout,
        timeout:const  Duration(seconds: 50));
        return phoneAuthCredential;

      
  }

  _onVerificationFailed(FirebaseAuthException exception) {
   }

  _onCodeSent(String verificationId, int? forceResendingToken) {
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

}
