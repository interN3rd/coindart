import 'package:flutter/material.dart';

class CoindartTheme {
  static ThemeData get defaultScheme {
    return ThemeData(
      primaryColor: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.white12,
      canvasColor: Colors.white12,

      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true
      ),

      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ),

      hintColor: Colors.white70
    );
  }
}