import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/providers/shared_preferences_provider.dart';
import '../domain/repositories/theme_repository.dart';
import '../themes/themes.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  const ThemeRepositoryImpl(this._prefs);

  static const String _themeKey = 'theme_mode';

  final SharedPreferences _prefs;

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeKey, themeMode.name);
  }

  @override
  ThemeMode getThemeMode() {
    late final ThemeMode themeMode = ThemeMode.values
            .where((ThemeMode mode) => mode.name == _prefs.getString(_themeKey))
            .firstOrNull ??
        ThemeMode.system;

    return themeMode;
  }
}

// ignore: always_specify_types
final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return ThemeRepositoryImpl(ref.read(sharedPreferencesProvider));
});
