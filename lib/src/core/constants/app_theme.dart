import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      colorScheme: const ColorScheme.light(
        surface: Color.fromRGBO(255, 229, 75, 1),
        primary: Colors.black,
      ),
      scaffoldBackgroundColor: const Color.fromRGBO(255, 229, 75, 1),
      textTheme:
          const TextTheme(bodyMedium: TextStyle(fontWeight: FontWeight.w600)));
}
