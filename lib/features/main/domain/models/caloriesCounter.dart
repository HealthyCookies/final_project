/// A class to calculate daily calorie requirements based on height, weight,
/// gender, and goal (gain, lose, or maintain weight).
class CaloriesCounter {
  CaloriesCounter({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.goal,
  });

  final double height; // in centimeters
  final double weight; // in kilograms
  final int age; // in years
  final String gender; // 'male' or 'female'
  final String goal; // 'gain', 'lose', or 'maintain'

  /// Calculates the Basal Metabolic Rate (BMR) using the formula.
  int calculateBMR() {
    double bmr;
    if (gender == 'male') {
      bmr = 66.362 + (13.7516 * weight) + (5.33 * height) - (6.677 * age);
    } else if (gender == 'female') {
      bmr = 667.593 + (9.247 * weight) + (1.798 * height) - (4.730 * age);
    } else {
      throw ArgumentError('Gender must be "male" or "female"');
    }
    return bmr.toInt(); // Convert the BMR to an integer
  }

  /// Adjusts BMR based on the goal (gain, lose, maintain weight).
  ///
  /// The method returns the number of calories required daily to meet the goal:
  /// - For gaining weight, 500 calories are added.
  /// - For losing weight, 500 calories are subtracted.
  /// - For maintaining weight, the BMR is returned directly.
  int calculateCalories() {
    final int bmr = calculateBMR();

    switch (goal) {
      case 'gain':
        return bmr + 500;
      case 'lose':
        return bmr - 500;
      case 'maintain':
        return bmr;
      default:
        throw ArgumentError('Goal must be "gain", "lose", or "maintain"');
    }
  }
}
