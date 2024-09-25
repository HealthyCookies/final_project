import 'package:final_project/domain/use_cases/use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDailyStats implements UseCase<Future<Map<String, String>>, void> {
  final SharedPreferences _prefs;

  GetDailyStats(this._prefs);

  @override
  Future<Map<String, String>> execute(void param) async {
    final Map<String, String> allPrefs =
        _prefs.getKeys().fold<Map<String, String>>({}, (map, key) {
      final value = _prefs.getString(key);
      if (value != null) {
        map[key] = value;
      }
      return map;
    });

    return allPrefs;
  }
}
