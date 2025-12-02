import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors from the logo
  static const Color darkGreen = Color(0xFF1B5E3E);
  static const Color limeYellow = Color(0xFFD4E157);
  static const Color brightYellow = Color(0xFFE8F34C);
  static const Color goldYellow = Color(0xFFCDDC39);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: darkGreen,
      primarySwatch: MaterialColor(0xFF1B5E3E, <int, Color>{
        50: Color(0xFFE3F0E9),
        100: Color(0xFFB9D9C8),
        200: Color(0xFF8BC0A3),
        300: Color(0xFF5DA77E),
        400: Color(0xFF3A9462),
        500: darkGreen,
        600: Color(0xFF175638),
        700: Color(0xFF124C30),
        800: Color(0xFF0E4228),
        900: Color(0xFF08311B),
      }),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme(
        primary: darkGreen,
        secondary: limeYellow,
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: darkGreen,
        onSurface: Colors.black87,
        onBackground: Colors.black87,
        onError: Colors.white,
        brightness: Brightness.light,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: darkGreen,
        foregroundColor: limeYellow,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: limeYellow,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkGreen,
          foregroundColor: limeYellow,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkGreen,
          side: BorderSide(color: darkGreen, width: 2),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkGreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkGreen, width: 2),
        ),
        labelStyle: TextStyle(color: darkGreen),
        floatingLabelStyle: TextStyle(color: darkGreen),
      ),

      // Icon theme
      iconTheme: IconThemeData(color: darkGreen),

      // Text theme
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: darkGreen, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
          color: darkGreen,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black87),
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: limeYellow,
        foregroundColor: darkGreen,
      ),
    );
  }
}
