import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/main/data/mealDbService.dart';
import '../../features/main/domain/models/meal.dart';
import '../../features/main/presentation/screens/add_meal_screen.dart';
import 'use_case.dart';

class AddMeal implements UseCase<Future<void>, AddMealParams> {
  const AddMeal(this._mealDbService);

  final MealDbService _mealDbService;

  @override
  Future<void> execute(AddMealParams params) async {
    final Meal meal = Meal(
      name: params.name,
      type: params.type,
      calories: params.calories,
      carbs: params.carbs,
      fat: params.fat,
      protein: params.protein,
    );

    await _mealDbService.insertData(<Meal>[meal]);
  }
}

// ignore: always_specify_types
final addMealUseCaseProvider = Provider<AddMeal>((ref) {
  final MealDbService mealDbService = ref.read(mealDbServiceProvider);
  return AddMeal(mealDbService);
});

@immutable
class AddMealParams {
  const AddMealParams({
    required this.name,
    required this.type,
    required this.calories,
    this.carbs = 0.0,
    this.fat = 0.0,
    this.protein = 0.0,
  });

  final String name;
  final MealType type;
  final double calories;
  final double carbs;
  final double fat;
  final double protein;
}
