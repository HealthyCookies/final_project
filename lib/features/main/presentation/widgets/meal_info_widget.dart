import 'package:flutter/material.dart';

import '../../../../themes/themes.dart';
import '../../../l10n/s.dart';
import '../../domain/models/meal.dart';

class MealInfoWidget extends StatelessWidget {
  const MealInfoWidget(this.meal, {super.key});

  final Meal meal;


  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal Name
            Text(meal.name),
            const SizedBox(height: 8.0),
            // Total Calories
            Text(S.of(context).postfixCalories(meal.calories.toStringAsFixed(0))),
            Divider(height: 20.0, thickness: 1.0, color: textColor),
            // Macronutrients
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoWidget(S.of(context).titleCarbs, meal.carbs, Colors.blue, textColor),
                _InfoWidget(S.of(context).titleProtein, meal.protein, Colors.green, textColor),
                _InfoWidget(S.of(context).titleFat, meal.fat, Colors.orange, textColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget(
      this.label,
      this.value,
      this.color,
      this.textColor
      );

  final String label;
  final double value;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          S.of(context).postfixGramms(value.toStringAsFixed(1)),
          style: TextStyle(
            fontSize: 16.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
