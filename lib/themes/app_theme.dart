import 'package:flutter/material.dart';

class AppTheme {
  // Main colors from the design
  static const Color primaryColor = Color(0xFF0D5C46); // Teal green
  static const Color secondaryColor = Color(0xFF0A3A5A); // Dark blue
  static const Color accentColor = Color(0xFFB85C44); // Rust/brown from second image
  static const Color backgroundColor = Color(0xFFF8F6F0); // Cream background
  static const Color yellowAccent = Color(0xFFFFB800); // Yellow from feature icon
  static const Color pinkAccent = Color(0xFFF8A5A5); // Pink from feature icon

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
        background: backgroundColor,
        error: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black87,
        ),
      ),
    );
  }
}
