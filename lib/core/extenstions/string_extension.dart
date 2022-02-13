import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension StringLocalization on String {
  String get locale => this.tr();
  void snackBarExtension(BuildContext context) {
    var snackBar = SnackBar(
      content: Text(this),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
