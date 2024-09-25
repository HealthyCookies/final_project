import 'package:flutter/material.dart';

import '../../domain/models/meal.dart';

class MealInfoWidget extends StatelessWidget {
  const MealInfoWidget(this.meal, {super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meal.name),
            const SizedBox(height: 8.0),
            Text('${meal.calories.toStringAsFixed(0)} kcal'),
            const Divider(height: 20.0, thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoWidget('Carbs', meal.carbs, Colors.blue),
                _InfoWidget('Protein', meal.protein, Colors.green),
                _InfoWidget('Fat', meal.fat, Colors.orange),
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
      );

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${value.toStringAsFixed(1)}g',
          style: TextStyle(
            fontSize: 16.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
