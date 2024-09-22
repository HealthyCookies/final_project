import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/helpers/no_params.dart';
import '../../data/theme_repository_impl.dart';
import '../repositories/theme_repository.dart';
import 'use_case.dart';

class GetThemeMode implements UseCase<ThemeMode, NoParams> {
  const GetThemeMode(this._repository);

  final ThemeRepository _repository;

  @override
  ThemeMode execute(NoParams _) {
    return _repository.getThemeMode();
  }
}

// ignore: always_specify_types
final getThemeModeUseCaseProvider = Provider<GetThemeMode>(
  (ProviderRef<GetThemeMode> ref) =>
      GetThemeMode(ref.read(themeRepositoryProvider)),
);
