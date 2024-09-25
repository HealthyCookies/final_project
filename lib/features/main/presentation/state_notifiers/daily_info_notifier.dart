import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/helpers/no_params.dart';
import '../../../../domain/use_cases/get_daily_stats.dart';
import '../../../../domain/use_cases/load_calories.dart';
import '../../../../domain/use_cases/save_calories.dart';
import '../../../../domain/use_cases/update_daily_stat.dart';
import '../../../../domain/use_cases/use_case.dart';
import '../../data/mealDbService.dart';
import '../../domain/models/meal.dart';
import '../widgets/show_add_daily_meal_dialog.dart';
import '../widgets/show_ccal_edit_dialog.dart';

part 'daily_info_notifier.freezed.dart';

@freezed
class DailyInfoState with _$DailyInfoState {
  const factory DailyInfoState({
    required List<Meal> meals,
    required bool loading,
    int? totalCalories,
    int? todaysCalories,
  }) = _DailyInfoState;

  factory DailyInfoState.loading() => const DailyInfoState(
        meals: <Meal>[],
        loading: true,
      );

  factory DailyInfoState.loaded(
    List<Meal> meals,
    int totalCalories,
    int todaysCalories,
  ) =>
      _DailyInfoState(
        meals: meals,
        loading: false,
        totalCalories: totalCalories,
        todaysCalories: todaysCalories,
      );

  factory DailyInfoState.initial() => const _DailyInfoState(
        meals: <Meal>[],
        loading: true,
      );
}

class MealsStateNotifier extends StateNotifier<DailyInfoState> {
  MealsStateNotifier(
    this._dailyInfoUseCase,
    this._updateDailyStatsUseCase,
    this._updateTotalCaloriesUseCase,
    this._loadCaloriesUseCase,
  ) : super(DailyInfoState.initial());

  final UseCase<Future<List<Meal>>, NoParams> _dailyInfoUseCase;
  final UseCase<Future<void>, Meal> _updateDailyStatsUseCase;
  final UseCase<Future<void>, int> _updateTotalCaloriesUseCase;
  final UseCase<int, NoParams> _loadCaloriesUseCase;

  Future<void> refreshInfo() async {
    state = DailyInfoState.loading();
    final List<Meal> result = await _dailyInfoUseCase.execute(NoParams());
    final int totalCalories = _loadCaloriesUseCase.execute(NoParams());
    int todaysCalories = 0;
    for (Meal meal in result) {
      todaysCalories += meal.calories.round();
    }
    state = DailyInfoState.loaded(result, totalCalories, todaysCalories);
  }

  Future<void> addDailyInfo(BuildContext context) async {
    final Meal? mealToAdd = await showAddDailyMealDialog(context);
    if (mealToAdd != null) {
      await _updateDailyStatsUseCase.execute(mealToAdd);
      refreshInfo();
    } else {
      // show warning
    }
  }

  Future<void> editTotalCcal(BuildContext context) async {
    final int? newTotalCcal = await showCcalEditDialog(context);

    if (newTotalCcal != null) {
      await _updateTotalCaloriesUseCase.execute(newTotalCcal);
      refreshInfo();
    } else {
      // show warning
    }
  }
}

// ignore: always_specify_types
final dailyInfoStateNotifierProvider = StateNotifierProvider(
  (StateNotifierProviderRef<MealsStateNotifier, DailyInfoState> ref) =>
      MealsStateNotifier(
    ref.read(getDailyStatsProvider),
    ref.read(updateDailyStatProvider),
    ref.read(saveCaloriesUseCaseProvider),
    ref.read(loadCaloriesUseCaseProvider),
  ),
);
