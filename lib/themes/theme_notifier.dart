import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common/helpers/no_params.dart';
import '../domain/use_cases/get_theme_mode.dart';
import '../domain/use_cases/save_theme_mode.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier(GetThemeMode getThemeMode, this._saveThemeModeUseCase)
      : super(getThemeMode.execute(NoParams()));

  final SaveThemeMode _saveThemeModeUseCase;

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeModeUseCase.execute(state);
  }
}

@riverpod
final StateNotifierProvider<ThemeNotifier, ThemeMode> themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (StateNotifierProviderRef<ThemeNotifier, ThemeMode> ref) => ThemeNotifier(
    ref.read(getThemeModeUseCaseProvider),
    ref.read(saveThemeModeUseCaseProvider),
  ),
);
