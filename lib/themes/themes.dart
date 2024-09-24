import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color mainGreen = Color(0xFF41CD68);
  static const Color secondaryGreen = Color(0xFF359C52);
  static const Color mainWhite = Color(0xFFFCFDF8);
  static const Color appBarBackgroundLight = Color(0xFF41CD68);
  static const Color textColorLight = Color(0xFF242424);

  // Dark Theme Colors
  static const Color primaryColorDark = Color(0xFF242424);
  static const Color secondaryColorDark = Color(0xFF673AB7);
  static const Color scaffoldBackgroundDark = Color(0xFF303030);
  static const Color appBarBackgroundDark = Color(0xFF673AB7);
  static const Color textColorDark = Color(0xFFFCFDF8);
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.mainGreen,
  colorScheme: const ColorScheme.light(
    primary: AppColors.mainGreen,
    secondary: AppColors.secondaryGreen,
    onPrimary: AppColors.textColorLight,
    surface: AppColors.mainWhite,
    onSurface: AppColors.textColorLight,
  ),
  scaffoldBackgroundColor: AppColors.mainWhite,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.appBarBackgroundLight,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textColorLight),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColorDark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColorDark,
    secondary: AppColors.secondaryColorDark,
    surface: AppColors.scaffoldBackgroundDark,
    onPrimary: AppColors.textColorDark,
    onSurface: AppColors.textColorDark,
  ),
  scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.appBarBackgroundDark,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textColorDark),
  ),
);
