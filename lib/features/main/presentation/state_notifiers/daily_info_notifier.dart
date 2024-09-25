import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/helpers/no_params.dart';
import '../../../../domain/use_cases/get_daily_stats.dart';
import '../../../../domain/use_cases/update_daily_stat.dart';
import '../../../../domain/use_cases/use_case.dart';
import '../../data/mealDbService.dart';
import '../../domain/models/meal.dart';
import '../widgets/show_add_daily_meal_dialog.dart';

part 'daily_info_notifier.freezed.dart';

@freezed
class DailyInfoState with _$DailyInfoState {
  const factory DailyInfoState({
    required List<Meal> meals,
    required bool loading,
  }) = _DailyInfoState;

  factory DailyInfoState.loading() => const DailyInfoState(
        meals: <Meal>[],
        loading: true,
      );

  factory DailyInfoState.loaded(List<Meal> meals) => _DailyInfoState(
        meals: meals,
        loading: false,
      );

  factory DailyInfoState.initial() => const _DailyInfoState(
        meals: <Meal>[],
        loading: false,
      );
}

class MealsStateNotifier extends StateNotifier<DailyInfoState> {
  MealsStateNotifier(this._dailyInfoUseCase, this._updateDailyStatsUseCase)
      : super(DailyInfoState.initial());

  final UseCase<Future<List<Meal>>, NoParams> _dailyInfoUseCase;
  final UseCase<Future<void>, Meal> _updateDailyStatsUseCase;

  Future<void> refreshInfo() async {
    state = DailyInfoState.loading();
    final List<Meal> result = await _dailyInfoUseCase.execute(NoParams());
    state = DailyInfoState.loaded(result);
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
}

// ignore: always_specify_types
final dailyInfoStateNotifierProvider = StateNotifierProvider(
  (StateNotifierProviderRef<MealsStateNotifier, DailyInfoState> ref) =>
      MealsStateNotifier(
    ref.read(getDailyStatsProvider),
    ref.read(updateDailyStatProvider),
  ),
);
