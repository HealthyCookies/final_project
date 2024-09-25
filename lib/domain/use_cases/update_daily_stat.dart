import 'package:final_project/domain/use_cases/use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/main/domain/models/meal.dart';

class UpdateDailyStat implements UseCase<Future<void>, Meal> {
  final SharedPreferences _prefs;

  UpdateDailyStat(this._prefs);

  @override
  Future<void> execute(Meal param) async {
    final now = DateTime.now();
    final dateKey = '${now.toIso8601String().split('T')[0]} ${param.type.name}';
    final value = param.id;

    await _prefs.setString(dateKey, value);
  }
}
