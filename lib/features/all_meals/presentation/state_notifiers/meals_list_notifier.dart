import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/use_cases/load_meals.dart';
import '../../../../domain/use_cases/use_case.dart';
import '../../../main/data/mealDbService.dart';
import '../../../main/domain/models/meal.dart';

part 'meals_list_notifier.freezed.dart';

@freezed
class MealsListState with _$MealsListState {
  const factory MealsListState({
    required List<Meal> meals,
    required bool loading,
  }) = _MealsListState;

  factory MealsListState.loading() => const _MealsListState(
        meals: <Meal>[],
        loading: true,
      );

  factory MealsListState.loaded(List<Meal> meals) => _MealsListState(
        meals: meals,
        loading: false,
      );

  factory MealsListState.initial() => const _MealsListState(
        meals: <Meal>[],
        loading: false,
      );
}

class MealsStateNotifier extends StateNotifier<MealsListState> {
  MealsStateNotifier(this.loadMealsUseCase) : super(MealsListState.initial());

  final UseCase<Future<List<Meal>>, LoadMealsParams> loadMealsUseCase;

  Future<void> loadMeals(LoadMealsParams param) async {
    state = MealsListState.loading();
    final List<Meal> result = await loadMealsUseCase.execute(param);
    state = MealsListState.loaded(result);
  }

  Future<void> refresh() async {
    await loadMeals(const LoadMealsParams());
  }
}

// ignore: always_specify_types
final mealsListStateNotifierProvider = StateNotifierProvider(
  (StateNotifierProviderRef<MealsStateNotifier, MealsListState> ref) =>
      MealsStateNotifier(LoadMeals(ref.read(mealDbServiceProvider))),
);
