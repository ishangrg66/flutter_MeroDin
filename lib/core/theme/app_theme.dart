import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.grey[50],
    fontFamily: 'NotoSansDevanagari',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'NotoSansDevanagari'),
      bodyMedium: TextStyle(fontFamily: 'NotoSansDevanagari'),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: false,
    primarySwatch: Colors.green,
    fontFamily: 'NotoSansDevanagari',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'NotoSansDevanagari'),
      bodyMedium: TextStyle(fontFamily: 'NotoSansDevanagari'),
    ),
  );
}
