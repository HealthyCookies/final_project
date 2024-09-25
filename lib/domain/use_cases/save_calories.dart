import 'package:final_project/domain/use_cases/use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/providers/shared_preferences_provider.dart';

class SaveCaloriesUseCase implements UseCase<Future<void>, int> {
  final SharedPreferences _prefs;

  SaveCaloriesUseCase(this._prefs);

  @override
  Future<void> execute(int calories) async {
    await _prefs.setInt('total_calories', calories);
  }
}

final saveCaloriesUseCaseProvider = Provider<SaveCaloriesUseCase>(
  (ref) => SaveCaloriesUseCase(ref.read(sharedPreferencesProvider)),
);
