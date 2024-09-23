import 'package:shared_preferences/shared_preferences.dart';

import '../features/main/data/activityDbService.dart';
import '../features/main/data/foodDbService.dart';
import '../features/main/data/ingredientDbService.dart';
import '../features/main/data/mealDbService.dart';
import '../features/main/domain/models/activity.dart';
import '../features/main/domain/models/food.dart';
import '../features/main/domain/models/ingredient.dart';
import '../features/main/domain/models/meal.dart';


class FirstLaunchUseCase {

  FirstLaunchUseCase(
      this._prefs,
      this._activityDbService,
      this._foodDbService,
      this._ingredientDbService,
      this._mealDbService,
      );
  final SharedPreferences _prefs;
  final ActivityDbService _activityDbService;
  final FoodDbService _foodDbService;
  final IngredientDbService _ingredientDbService;
  final MealDbService _mealDbService;

  Future<void> execute() async {
    final bool isFirstLaunch = _prefs.getBool('is_first_launch') ?? true;

    if (isFirstLaunch) {
      await _insertHardcodedData();
      _prefs.setBool('is_first_launch', false);
    }
  }

  Future<void> _insertHardcodedData() async {
    final List<Activity> activities = [
      Activity(name: 'Running', caloriesBurned: 300.0),
      Activity(name: 'Cycling', caloriesBurned: 250.0),
      Activity(name: 'Swimming', caloriesBurned: 400.0),
      Activity(name: 'Walking', caloriesBurned: 150.0),
      Activity(name: 'Yoga', caloriesBurned: 200.0),
      Activity(name: 'Hiking', caloriesBurned: 350.0),
      Activity(name: 'Jumping Rope', caloriesBurned: 300.0),
      Activity(name: 'Dancing', caloriesBurned: 220.0),
      Activity(name: 'Strength Training', caloriesBurned: 280.0),
      Activity(name: 'Rowing', caloriesBurned: 350.0),
    ];

    final List<Food> foods = [
      Food(name: 'Apple', calories: 95.0, carbs: 25.0, protein: 0.5, fat: 0.3),
      Food(name: 'Banana', calories: 105.0, carbs: 27.0, protein: 1.3, fat: 0.3),
      Food(name: 'Chicken Breast', calories: 165.0, carbs: 0.0, protein: 31.0, fat: 3.6),
      Food(name: 'Broccoli', calories: 55.0, carbs: 11.2, protein: 3.7, fat: 0.6),
      Food(name: 'Rice', calories: 206.0, carbs: 45.0, protein: 4.3, fat: 0.4),
      Food(name: 'Egg', calories: 68.0, carbs: 0.6, protein: 5.5, fat: 4.8),
      Food(name: 'Oats', calories: 68.0, carbs: 12.0, protein: 2.5, fat: 1.4),
      Food(name: 'Yogurt', calories: 59.0, carbs: 3.6, protein: 10.0, fat: 0.4),
      Food(name: 'Almonds', calories: 576.0, carbs: 21.6, protein: 21.2, fat: 50.0),
      Food(name: 'Spinach', calories: 23.0, carbs: 3.6, protein: 2.9, fat: 0.4),
    ];

    final List<Ingredient> ingredients = [
      Ingredient(name: 'Salt'),
      Ingredient(name: 'Pepper'),
      Ingredient(name: 'Garlic'),
      Ingredient(name: 'Onion'),
      Ingredient(name: 'Tomato'),
      Ingredient(name: 'Olive Oil'),
      Ingredient(name: 'Basil'),
      Ingredient(name: 'Oregano'),
      Ingredient(name: 'Cumin'),
      Ingredient(name: 'Paprika'),
    ];

    final List<Meal> meals = [
      Meal(
        name: 'Fruit Breakfast',
        calories: 300.0,
        carbs: 45.0,
        protein: 15.0,
        fat: 8.0,
        foods: <String, double>{'Apple': 100, 'Banana': 50},
      ),
      Meal(
        name: 'Chicken breast with broccoli and rice',
        calories: 600.0,
        carbs: 70.0,
        protein: 35.0,
        fat: 20.0,
        foods: <String, double>{'Chicken Breast': 200, 'Broccoli': 100, 'Rice': 150},
      ),
      Meal(
        name: 'Salmon with spinach and rice',
        calories: 500.0,
        carbs: 40.0,
        protein: 30.0,
        fat: 15.0,
        foods: <String, double>{'Salmon': 200, 'Spinach': 100, 'Rice': 100},
      ),
      Meal(
        name: 'Snack',
        calories: 200.0,
        carbs: 20.0,
        protein: 10.0,
        fat: 8.0,
        foods: <String, double>{'Yogurt': 150, 'Almonds': 25},
      ),
      Meal(
        name: 'Banana overnight oats',
        calories: 400.0,
        carbs: 50.0,
        protein: 20.0,
        fat: 15.0,
        foods: <String, double>{'Oats': 100, 'Banana': 50, 'Milk': 70},
      ),
      Meal(
        name: 'Omlete',
        calories: 450.0,
        carbs: 60.0,
        protein: 30.0,
        fat: 10.0,
        foods: <String, double>{'Egg': 2, 'Spinach': 50, 'Tomato': 50},
      ),
      Meal(
        name: 'Ice cream',
        calories: 350.0,
        carbs: 60.0,
        protein: 5.0,
        fat: 15.0,
        foods: <String, double>{'Ice Cream': 100, 'Chocolate': 50},
      ),
      Meal(
        name: 'Banana Smoothie',
        calories: 250.0,
        carbs: 45.0,
        protein: 5.0,
        fat: 7.0,
        foods: <String, double>{'Banana': 100, 'Yogurt': 150},
      ),
      Meal(
        name: 'Green Salad',
        calories: 300.0,
        carbs: 20.0,
        protein: 10.0,
        fat: 15.0,
        foods: <String, double>{'Olive Oil': 20, 'Spinach': 100, 'Tomato': 50},
      ),
      Meal(
        name: 'Chicken Wrap',
        calories: 500.0,
        carbs: 65.0,
        protein: 25.0,
        fat: 15.0,
        foods: <String, double>{'Tortilla': 100, 'Chicken Breast': 150, 'Lettuce': 50},
      ),
    ];

    await _activityDbService.insertData(activities);
    await _foodDbService.insertData(foods);
    await _ingredientDbService.insertData(ingredients);
    await _mealDbService.insertData(meals);
  }
}
