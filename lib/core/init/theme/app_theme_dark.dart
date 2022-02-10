import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppThemeDark extends AppTheme {
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    if (_instance == null) {
      _instance = AppThemeDark._init();
      return _instance!;
    }
    return _instance!;
  }

  @override
  ThemeData get theme => ThemeData(
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
        scaffoldBackgroundColor: const Color(0xFF2f5392),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF013d63),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: const Color(0xFF1e63b8))),
      );

  AppThemeDark._init();
}
