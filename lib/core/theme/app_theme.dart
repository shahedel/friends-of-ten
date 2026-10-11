import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xFF0A0906);
  static const Color red = Color(0xFFE6371F);
  static const Color redGlow = Color(0xFFFF5A3C);
  static const Color white = Colors.white;
  static const Color whiteFaint = Color(0x66FFFFFF);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.black,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.red,
        secondary: AppColors.white,
        surface: AppColors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}