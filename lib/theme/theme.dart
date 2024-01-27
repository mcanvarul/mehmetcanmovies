import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/theme/ITheme.dart';

class DarkTheme extends ITheme {
  DarkTheme._init();
  static DarkTheme? _instace;
  static DarkTheme get instance {
    if (_instace != null) return _instace!;
    _instace = DarkTheme._init();
    return _instace!;
  }

  final ThemeData _darkTheme = ThemeData.dark();

  final Color baseColor = Colors.black;
  @override
  ThemeData get data => ThemeData(
      scaffoldBackgroundColor: baseColor,
      appBarTheme: AppBarTheme(
        backgroundColor: baseColor,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          minimumSize: Size(double.maxFinite, 60),
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardTheme(color: Colors.grey.shade400),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey.shade900,
        filled: true,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        style: ListTileStyle.drawer,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ));
}
