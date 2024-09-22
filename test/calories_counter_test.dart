import 'package:final_project/features/main/domain/models/caloriesCounter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CaloriesCounter', () {
    test('BMR calculation for female', () {
      final CaloriesCounter counter = CaloriesCounter(
        height: 180.0,
        weight: 80.0,
        age: 25,
        gender: 'female',
        goal: 'maintain',
      );
      final int bmr = counter.calculateBMR();

      expect(bmr, inInclusiveRange(1612, 1613));
    });

    test('BMR calculation for male', () {
      final CaloriesCounter counter = CaloriesCounter(
        height: 180.0,
        weight: 85.0,
        age: 30,
        gender: 'male',
        goal: 'maintain',
      );
      final int bmr = counter.calculateBMR();

      expect(bmr, inInclusiveRange(1994, 1995));
    });

    test('Calories for weight gain', () {
      final CaloriesCounter counter = CaloriesCounter(
        height: 180.0,
        weight: 80.0,
        age: 25,
        gender: 'female',
        goal: 'gain',
      );
      final int calories = counter.calculateCalories();

      expect(calories, inInclusiveRange(2112, 2113));
    });

    test('Calories for weight loss', () {
      final CaloriesCounter counter = CaloriesCounter(
        height: 180.0,
        weight: 80.0,
        age: 25,
        gender: 'female',
        goal: 'lose',
      );
      final int calories = counter.calculateCalories();

      expect(calories, inInclusiveRange(1112, 1113));
    });


    test('Invalid gender throws error', () {
      final counter = CaloriesCounter(
        height: 180.0,
        weight: 80.0,
        age: 25,
        gender: 'other',
        goal: 'maintain',
      );

      expect(() => counter.calculateBMR(), throwsArgumentError);
    });

    test('Invalid goal throws error', () {
      final counter = CaloriesCounter(
        height: 180.0,
        weight: 80.0,
        age: 25,
        gender: 'male',
        goal: 'unknown',  // Invalid goal
      );

      expect(() => counter.calculateCalories(), throwsArgumentError);
    });
  });
}
