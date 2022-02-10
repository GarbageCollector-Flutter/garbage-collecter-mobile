// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_sign_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OtpSignViewModel on _OtpSignViewModelBase, Store {
  final _$smsCodeAtom = Atom(name: '_OtpSignViewModelBase.smsCode');

  @override
  String? get smsCode {
    _$smsCodeAtom.reportRead();
    return super.smsCode;
  }

  @override
  set smsCode(String? value) {
    _$smsCodeAtom.reportWrite(value, super.smsCode, () {
      super.smsCode = value;
    });
  }

  final _$_OtpSignViewModelBaseActionController =
      ActionController(name: '_OtpSignViewModelBase');

  @override
  void smsCodeSet(PhoneAuthCredential phoneAuthCredential) {
    final _$actionInfo = _$_OtpSignViewModelBaseActionController.startAction(
        name: '_OtpSignViewModelBase.smsCodeSet');
    try {
      return super.smsCodeSet(phoneAuthCredential);
    } finally {
      _$_OtpSignViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
smsCode: ${smsCode}
    ''';
  }
}
