import 'package:flutter/material.dart';

class AppTheme {
  ThemeData theme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey.shade200,
      fontFamily: 'VarelaRound',
      textTheme: textTheme(),
      elevatedButtonTheme: elevatedButtonTheme(),
      cardTheme: cardTheme(),
    );
  }

  TextTheme textTheme() {
    return TextTheme(
      subtitle2: TextStyle(color: Colors.grey.shade600),
      headline4: TextStyle(color: Colors.grey.shade800),
    );
  }

  CardTheme cardTheme() {
    return CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onSurface: Colors.deepPurple.shade800,
      ),
    );
  }
}
