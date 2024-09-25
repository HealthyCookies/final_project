import 'package:flutter/material.dart';

import '../../../l10n/s.dart';
import '../../../main/domain/models/meal.dart';
import 'macro_pie_painter.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal, this.onTap});

  final Meal meal;
  final VoidCallback? onTap;

  double get totalMacros => meal.carbs + meal.protein + meal.fat;

  @override
  Widget build(BuildContext context) {
    final hasMacros = totalMacros > 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(meal.name),
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.local_fire_department,
                          color: Colors.orange, size: 20),
                      const SizedBox(width: 4),
                      Text(S
                          .of(context)
                          .postfixCalories(meal.calories.toStringAsFixed(0))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (hasMacros) ...[
                Row(
                  children: <Widget>[
                    CustomPaint(
                      size: const Size(100, 100),
                      painter: MacroPiePainter(
                        carbs: meal.carbs,
                        protein: meal.protein,
                        fat: meal.fat,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _MacroRow(
                            color: Colors.blue,
                            label: S.of(context).titleCarbs,
                            amount: meal.carbs,
                            percentage: totalMacros > 0
                                ? (meal.carbs / totalMacros * 100)
                                .toStringAsFixed(1)
                                : '0.0',
                          ),
                          const SizedBox(height: 8),
                          _MacroRow(
                            color: Colors.red,
                            label: S.of(context).titleProtein,
                            amount: meal.protein,
                            percentage: totalMacros > 0
                                ? (meal.protein / totalMacros * 100)
                                .toStringAsFixed(1)
                                : '0.0',
                          ),
                          const SizedBox(height: 8),
                          _MacroRow(
                            color: Colors.green,
                            label: S.of(context).titleFat,
                            amount: meal.fat,
                            percentage: totalMacros > 0
                                ? (meal.fat / totalMacros * 100)
                                .toStringAsFixed(1)
                                : '0.0',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text('Foods:'),
                // ),
                // const SizedBox(height: 8),
                // ...meal.foods.entries.map(
                //   (final MapEntry<String, double> entry) => Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 2.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(entry.key),
                //         Text('${entry.value.toStringAsFixed(1)}g'),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


class _MacroRow extends StatelessWidget {
  const _MacroRow({
    required this.color,
    required this.label,
    required this.amount,
    required this.percentage,
  });

  final Color color;
  final String label;
  final double amount;
  final String percentage;  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: ${S.of(context).postfixGramms(amount.toStringAsFixed(1))}',
          ),
        ),
        Text(
          '$percentage%',
        ),
      ],
    );
  }
}