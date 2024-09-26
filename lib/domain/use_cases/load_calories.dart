import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/helpers/no_params.dart';
import '../../common/providers/shared_preferences_provider.dart';
import 'use_case.dart';


class LoadCaloriesUseCase implements UseCase<int, NoParams> {
  final SharedPreferences _prefs;

  LoadCaloriesUseCase(this._prefs);

  @override
  int execute(NoParams _) {
    return _prefs.getInt('total_calories') ?? 2000;
  }
}

final loadCaloriesUseCaseProvider = Provider<LoadCaloriesUseCase>(
      (ref) => LoadCaloriesUseCase(ref.read(sharedPreferencesProvider)),
);
