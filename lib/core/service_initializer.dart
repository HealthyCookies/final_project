import 'package:shared_preferences/shared_preferences.dart';

import '../features/main/data/activityDbService.dart';
import '../features/main/data/foodDbService.dart';
import '../features/main/data/ingredientDbService.dart';
import '../features/main/data/mealDbService.dart';
import '../use_cases/first_launch_use_case.dart';

class ServiceInitializer {

  ServiceInitializer(this.prefs)
      : activityDbService = ActivityDbService(),
        foodDbService = FoodDbService(),
        ingredientDbService = IngredientDbService(),
        mealDbService = MealDbService(),
        firstLaunchUseCase = FirstLaunchUseCase(
          prefs,
          ActivityDbService(),
          FoodDbService(),
          IngredientDbService(),
          MealDbService(),
        );
  final SharedPreferences prefs;
  final ActivityDbService activityDbService;
  final FoodDbService foodDbService;
  final IngredientDbService ingredientDbService;
  final MealDbService mealDbService;
  final FirstLaunchUseCase firstLaunchUseCase;

  Future<void> initializeServices() async {
    await firstLaunchUseCase.execute();
  }
}
