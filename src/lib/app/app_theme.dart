// app/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF8DCBC8);
  static const Color darkGrey = Color(0xFF333333); // Cor cinza escuro

  // Tema claro
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme( // Remova o 'const'
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomAppBarTheme: BottomAppBarTheme( // Remova o 'const'
      color: primaryColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
    ),
  );

  // Tema escuro (opcional, você pode personalizar)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkGrey,
    scaffoldBackgroundColor: Colors.grey[850],
    appBarTheme: AppBarTheme( // Remova o 'const'
      backgroundColor: darkGrey,
      foregroundColor: Colors.white,
    ),
    bottomAppBarTheme: BottomAppBarTheme( // Remova o 'const'
      color: darkGrey,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
      bodySmall: TextStyle(fontSize: 14, color: Colors.white),
    ),
  );
}
