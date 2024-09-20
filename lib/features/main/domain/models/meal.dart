/// Represents a meal with its nutritional values and a list of foods.
class Meal {
  /// Creates a [Meal] with a given [name], [calories], and optional
  /// nutritional values like [carbs], [protein], [fat], and a list of [foods].
  ///
  /// [carbs], [protein], and [fat] default to 0 if not provided. [foods] is an
  /// optional map containing food names and their respective weights in grams.
  Meal({
    required this.name,
    required this.calories,
    this.carbs = 0.0,
    this.protein = 0.0,
    this.fat = 0.0,
    this.foods = const <String, double>{},
  });

  /// The name of the meal (e.g. 'Breakfast').
  final String name;

  /// The total calories in the meal.
  final double calories;

  /// The amount of carbohydrates in the meal, in grams.
  double carbs;

  /// The amount of protein in the meal, in grams.
  double protein;

  /// The amount of fat in the meal, in grams.
  double fat;

  /// A map of foods included in the meal, with the key as the food name
  /// and the value as its weight in grams (e.g. {'Apple': 100.0}).
  final Map<String, double> foods;
}
