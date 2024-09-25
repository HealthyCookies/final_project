import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/helpers/no_params.dart';
import '../../../../domain/use_cases/load_daily_info.dart';
import '../../../../domain/use_cases/use_case.dart';
import '../../data/mealDbService.dart';
import '../../domain/models/meal.dart';

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
  MealsStateNotifier(this.dailyInfoUseCase) : super(DailyInfoState.initial());

  final UseCase<Future<List<Meal>>, NoParams> dailyInfoUseCase;
  List<Meal> _allMeals = [];

  Future<void> refreshInfo() async {
    state = DailyInfoState.loading();
    final List<Meal> result = await dailyInfoUseCase.execute(NoParams());
    _allMeals = result; // Store all meals for filtering
    state = DailyInfoState.loaded(result);
  }

  Future<void> loadMeals(String query) async {
    if (_allMeals.isEmpty) {
      // If meals are not loaded yet, load them
      await refreshInfo();
    }
    final List<Meal> filteredMeals = _allMeals
        .where((meal) =>
        meal.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    state = DailyInfoState.loaded(filteredMeals);
  }
}

// ignore: always_specify_types
final dailyInfoStateNotifierProvider = StateNotifierProvider(
  (StateNotifierProviderRef<MealsStateNotifier, DailyInfoState> ref) =>
      MealsStateNotifier(LoadDailyInfo(ref.read(mealDbServiceProvider))),
);
