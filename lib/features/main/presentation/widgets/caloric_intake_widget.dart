import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../themes/themes.dart';
import '../../../l10n/s.dart';

class CaloricIntakePainter extends CustomPainter {
  CaloricIntakePainter({
    required this.progress,
    required this.remainingCalories,
    required this.textColor,
    required this.localization,
    this.progressColor = Colors.green,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 7.0,
    this.textStyleCalories,
    this.textStyleLabel,
  });

  final double progress;
  final int remainingCalories;
  final AppLocalizations localization;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final TextStyle? textStyleCalories;
  final TextStyle? textStyleLabel;
  final Color textColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = (size.width - strokeWidth) / 2;

    final Paint backgroundPaint = Paint()
      ..color = backgroundColor.withOpacity(0.3)
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );

    final TextStyle caloriesStyle = textStyleCalories ??
        TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: textColor,
        );

    final TextStyle labelStyle = textStyleLabel ??
        TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        );

    final TextSpan caloriesText = TextSpan(
      text: '$remainingCalories',
      style: caloriesStyle,
    );

    final TextPainter textPainterCalories = TextPainter(
      text: caloriesText,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainterCalories.layout(maxWidth: size.width);

    final Offset offsetCalories = Offset(
      center.dx - textPainterCalories.width / 2,
      center.dy - textPainterCalories.height / 2 - 5,
    );

    textPainterCalories.paint(canvas, offsetCalories);

    final TextSpan labelText = TextSpan(
      text: localization.caloricIntakeKcal,
      style: labelStyle,
    );

    final TextPainter textPainterLabel = TextPainter(
      text: labelText,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainterLabel.layout(maxWidth: size.width);

    final Offset offsetLabel = Offset(
      center.dx - textPainterLabel.width / 2,
      center.dy + textPainterCalories.height / 2 - 5,
    );

    textPainterLabel.paint(canvas, offsetLabel);
  }

  @override
  bool shouldRepaint(CaloricIntakePainter oldDelegate) {

    return oldDelegate.progress != progress ||
        oldDelegate.remainingCalories != remainingCalories ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.textStyleCalories != textStyleCalories ||
        oldDelegate.textStyleLabel != textStyleLabel ||
        oldDelegate.textColor != textColor;
  }
}

class CaloricIntakeWidget extends StatelessWidget {
  const CaloricIntakeWidget({
    super.key,
    required this.currentCalories,
    required this.goalCalories,
    this.size = const Size(150, 150),
    this.progressColor = Colors.green,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 7.0,
    this.textStyleCalories,
    this.textStyleLabel,
  });

  final int currentCalories;
  final int goalCalories;
  final Size size;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final TextStyle? textStyleCalories;
  final TextStyle? textStyleLabel;

  @override
  Widget build(BuildContext context) {
    final int remainingCalories =
    (goalCalories - currentCalories).clamp(0, goalCalories);
    final double targetProgress = currentCalories / goalCalories;

    final ThemeData theme = Theme.of(context);
    final Color progressColor = theme.appBarTheme.backgroundColor!;
    final Color backgroundColor = theme.colorScheme.onPrimaryContainer;
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(
        begin: 0.0,
        end: targetProgress.clamp(0.0, 1.0),
      ),
      builder: (BuildContext context, double progress, _) {
        return Center(
          child: CustomPaint(
            size: size,
            painter: CaloricIntakePainter(
              progress: progress,
              remainingCalories: remainingCalories,
              localization: S.of(context),
              progressColor: progressColor,
              backgroundColor: backgroundColor,
              strokeWidth: strokeWidth,
              textStyleCalories: textStyleCalories,
              textStyleLabel: textStyleLabel,
              textColor: textColor,
            ),
          ),
        );
      },
    );
  }
}
