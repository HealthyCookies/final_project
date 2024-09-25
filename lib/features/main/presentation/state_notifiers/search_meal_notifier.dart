import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/use_cases/load_meals.dart';
import '../../../../domain/use_cases/use_case.dart';
import '../../domain/models/meal.dart';

class SearchMealNotifier extends StateNotifier<List<Meal>> {
  SearchMealNotifier(this._loadMealsUseCase) : super(<Meal>[]);

  final UseCase<Future<List<Meal>>, LoadMealsParams> _loadMealsUseCase;

  Future<void> searchMeals(String query) async {
    state = await _loadMealsUseCase.execute(LoadMealsParams(name: query));
  }
}

StateNotifierProvider<SearchMealNotifier, List<Meal>>
    searchMealStateNotifierProvider =
    StateNotifierProvider<SearchMealNotifier, List<Meal>>(
  (StateNotifierProviderRef<SearchMealNotifier, List<Meal>> ref) =>
      SearchMealNotifier(ref.read(loadMealsUseCaseProvider)),
);
