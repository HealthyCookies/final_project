/// Represents an individual food item with its nutritional values.
class Food {
  /// Creates a [Food] with a given [name], [calories], and optional
  /// nutritional values like [carbs], [protein], and [fat].
  ///
  /// [carbs], [protein], and [fat] default to 0 if not provided.
  Food({
    required this.name,
    required this.calories,
    this.carbs = 0.0,
    this.protein = 0.0,
    this.fat = 0.0,
  });

  /// The name of the food (e.g. 'Apple').
  final String name;

  /// The total calories in the food item.
  final double calories;

  /// The amount of carbohydrates in the food item, in grams.
  double carbs;

  /// The amount of protein in the food item, in grams.
  double protein;

  /// The amount of fat in the food item, in grams.
  double fat;
}
