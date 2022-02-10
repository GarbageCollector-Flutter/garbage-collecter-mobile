import 'package:flutter/cupertino.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    if (_instance == null) {
      _instance = LanguageManager._init();
      return _instance!;
    }
    return _instance!;
  }

   final enLocale = const Locale("en","US");
   final germen = const Locale("de","DE");
  List<Locale> get supportedLocales =>[enLocale,germen];

  LanguageManager._init();
  
}
