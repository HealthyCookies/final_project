import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/helpers/no_params.dart';
import '../../common/providers/shared_preferences_provider.dart';
import '../../features/main/data/mealDbService.dart';
import '../../features/main/domain/models/meal.dart';
import '../../features/main/presentation/screens/add_meal_screen.dart';
import 'use_case.dart';

class GetDailyStats implements UseCase<Future<List<Meal>>, NoParams> {
  final SharedPreferences _prefs;
  final MealDbService _mealDbService;

  GetDailyStats(this._prefs, this._mealDbService);

  @override
  Future<List<Meal>> execute(NoParams _) async {
    final DateTime now = DateTime.now();
    final String currentDate = now.toIso8601String().split('T')[0];

    final List<Meal> result = [];

    for (final MealType type in MealType.values) {
      final String key = '$currentDate ${type.name}';
      final String? id = _prefs.getString(key);

      if (id != null) {
        final List<Meal> meals = await _mealDbService.getData(1, 0, id: id);
        if (meals.isNotEmpty) {
          result.add(meals.first);
        }
      }
    }

    return result;
  }
}

final getDailyStatsProvider = Provider<GetDailyStats>((ref) {
  return GetDailyStats(
    ref.read(sharedPreferencesProvider),
    ref.read(mealDbServiceProvider),
  );
});
