import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.white;
  static const Color secondary = Colors.black;
  static const Color accent = Color(0xFF4DC2E0);
}

class AppTextStyles {
  static const TextStyle small = TextStyle(fontSize: 12, color: AppColors.secondary);
  static const TextStyle normal = TextStyle(fontSize: 14, color: AppColors.secondary);
  static const TextStyle medium = TextStyle(fontSize: 16, color: AppColors.secondary);
  static const TextStyle large = TextStyle(fontSize: 20, color: AppColors.secondary);
  static const TextStyle headline = TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.secondary);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Jakarta',
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.primary,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
      ),
      textTheme: const TextTheme(
        bodySmall: AppTextStyles.small,   // 12
        bodyMedium: AppTextStyles.normal, // 14
        bodyLarge: AppTextStyles.medium,  // 16
        titleMedium: AppTextStyles.large, // 20
        headlineLarge: AppTextStyles.headline, // 36
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
