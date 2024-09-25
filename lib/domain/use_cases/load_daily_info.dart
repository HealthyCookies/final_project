import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/helpers/no_params.dart';
import '../../features/main/data/mealDbService.dart';
import '../../features/main/domain/models/meal.dart';
import 'use_case.dart';

class LoadDailyInfo implements UseCase<Future<List<Meal>>, NoParams> {
  const LoadDailyInfo(this._mealDbService);

  final MealDbService _mealDbService;

  @override
  Future<List<Meal>> execute(NoParams _) async {
    final List<Meal> result =
        await _mealDbService.getData(3, 0); // get todays data
    return result;
  }
}

final Provider<LoadDailyInfo> loadDailyInfoUseCaseProvider =
    Provider<LoadDailyInfo>((ProviderRef<LoadDailyInfo> ref) {
  final MealDbService mealDbService = ref.watch(mealDbServiceProvider);
  return LoadDailyInfo(mealDbService);
});
