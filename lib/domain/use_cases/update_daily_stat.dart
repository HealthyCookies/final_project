import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/providers/shared_preferences_provider.dart';
import '../../features/main/domain/models/meal.dart';
import 'use_case.dart';

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

final updateDailyStatProvider = Provider<UpdateDailyStat>((ref) {
  return UpdateDailyStat(ref.read(sharedPreferencesProvider));
});
