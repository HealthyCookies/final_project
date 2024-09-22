import 'package:flutter/material.dart';

abstract interface class ThemeRepository {
  Future<void> saveThemeMode(ThemeMode themeMode);
  ThemeMode getThemeMode();
}
