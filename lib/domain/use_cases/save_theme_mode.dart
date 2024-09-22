import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/theme_repository_impl.dart';
import '../repositories/theme_repository.dart';
import 'use_case.dart';

class SaveThemeMode implements UseCase<Future<void>, ThemeMode> {
  const SaveThemeMode(this._repository);

  final ThemeRepository _repository;

  @override
  Future<void> execute(ThemeMode themeMode) async {
    await _repository.saveThemeMode(themeMode);
  }
}

// ignore: always_specify_types
final saveThemeModeUseCaseProvider = Provider<SaveThemeMode>((ref) {
  return SaveThemeMode(ref.read(themeRepositoryProvider));
});
