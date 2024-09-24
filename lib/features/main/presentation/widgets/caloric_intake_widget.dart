import 'package:flutter/material.dart';
import '../../../../themes/themes.dart';

class CaloricIntakePainter extends CustomPainter {
  CaloricIntakePainter({
    required this.progress,
    required this.remainingCalories,
    required this.backgroundColor,
    required this.progressColor,
    required this.textColor,
  });

  final double progress;
  final int remainingCalories;
  final Color backgroundColor;
  final Color progressColor;
  final Color textColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;

    final double sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    final TextPainter textPainterCalories = TextPainter(
      text: TextSpan(
        text: '$remainingCalories',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainterCalories.layout(maxWidth: size.width);
    final Offset offsetCalories = Offset(
      center.dx - textPainterCalories.width / 2,
      center.dy - textPainterCalories.height / 2 - 10,
    );
    textPainterCalories.paint(canvas, offsetCalories);

    final TextPainter textPainterKcalLeft = TextPainter(
      text: TextSpan(
        text: 'KCAL LEFT',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainterKcalLeft.layout(minWidth: 0, maxWidth: size.width);
    final Offset offsetKcalLeft = Offset(
      center.dx - textPainterKcalLeft.width / 2,
      center.dy + textPainterCalories.height / 2 - 5,
    );
    textPainterKcalLeft.paint(canvas, offsetKcalLeft);
  }

  @override
  bool shouldRepaint(CaloricIntakePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.remainingCalories != remainingCalories ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.textColor != textColor;
  }
}


class CaloricIntakeWidget extends StatelessWidget {
  const CaloricIntakeWidget({
    super.key,
    required this.currentCalories,
    required this.goalCalories,
  });

  final int currentCalories;
  final int goalCalories;

  @override
  Widget build(BuildContext context) {
    final double progress = currentCalories / goalCalories;
    final int remainingCalories =
    (goalCalories - currentCalories).clamp(0, goalCalories);

    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    final Color backgroundColor = isDarkMode
        ? AppColors.primaryColorDark
        : Colors.grey[300]!;
    final Color progressColor = isDarkMode
        ? AppColors.secondaryColorDark
        : AppColors.mainGreen;
    final Color textColor = isDarkMode
        ? AppColors.textColorDark
        : AppColors.textColorLight;

    return Center(
      child: CustomPaint(
        size: const Size(150, 150),
        painter: CaloricIntakePainter(
          progress: progress.clamp(0.0, 1.0),
          remainingCalories: remainingCalories,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          textColor: textColor,
        ),
      ),
    );
  }
}
