
import 'dart:math';

import 'package:flutter/material.dart';

class MacroPiePainter extends CustomPainter {
  const MacroPiePainter({
    required this.carbs,
    required this.protein,
    required this.fat,
  });

  final double carbs;
  final double protein;
  final double fat;

  @override
  void paint(Canvas canvas, Size size) {
    final double total = carbs + protein + fat;
    if (total == 0) {
      return;
    }

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()..style = PaintingStyle.fill;

    double startAngle = -90.0;

    final double carbsSweep = (carbs / total) * 360.0;
    paint.color = Colors.blue;
    canvas.drawArc(
      rect,
      degreeToRadian(startAngle),
      degreeToRadian(carbsSweep),
      true,
      paint,
    );
    startAngle += carbsSweep;

    final double proteinSweep = (protein / total) * 360.0;
    paint.color = Colors.red;
    canvas.drawArc(
      rect,
      degreeToRadian(startAngle),
      degreeToRadian(proteinSweep),
      true,
      paint,
    );
    startAngle += proteinSweep;

    final double fatSweep = (fat / total) * 360;
    paint.color = Colors.green;
    canvas.drawArc(
      rect,
      degreeToRadian(startAngle),
      degreeToRadian(fatSweep),
      true,
      paint,
    );
  }

  double degreeToRadian(double degree) {
    return degree * (pi / 180);
  }

  @override
  bool shouldRepaint(covariant MacroPiePainter oldDelegate) {
    return carbs != oldDelegate.carbs ||
        protein != oldDelegate.protein ||
        fat != oldDelegate.fat;
  }
}
