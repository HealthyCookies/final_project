import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../l10n/s.dart';

class CaloricIntakePainter extends CustomPainter {

  CaloricIntakePainter({
    required this.progress,
    required this.remainingCalories,
    required this.localization,

  });
  final double progress;
  final int remainingCalories;
  final AppLocalizations localization;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    // Paint the background circle
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Paint the progress circle
    final Paint progressPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;

    final double sweepAngle = 2 * 3.141592653589793 * progress; // Full circle in radians
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2, // Start at the top
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw the remaining calories number (larger)
    final TextPainter textPainterCalories = TextPainter(
      text: TextSpan(
        text: '$remainingCalories',
        style: const TextStyle(
          fontSize: 30, // Larger font size for the number
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainterCalories.layout(maxWidth: size.width);
    final Offset offsetCalories = Offset(
      center.dx - textPainterCalories.width / 2,
      center.dy - textPainterCalories.height / 2 - 10, // Adjust position slightly up
    );
    textPainterCalories.paint(canvas, offsetCalories);

    // Draw the "KCAL LEFT" text (smaller)
    final TextPainter textPainterKcalLeft = TextPainter(
      text: TextSpan(
        text: localization.caloricIntakeKcal,
        style: const TextStyle(
          fontSize: 15, // Smaller font size for the text
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainterKcalLeft.layout(minWidth: 0, maxWidth: size.width);
    final offsetKcalLeft = Offset(
      center.dx - textPainterKcalLeft.width / 2,
      center.dy + textPainterCalories.height / 2 - 5, // Position below the number
    );
    textPainterKcalLeft.paint(canvas, offsetKcalLeft);
  }

  @override
  bool shouldRepaint(CaloricIntakePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.remainingCalories != remainingCalories;
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
    final int remainingCalories = (goalCalories - currentCalories).clamp(0, goalCalories);

    return Center(
      child: CustomPaint(
        size: const Size(150, 150), // Size of the circular progress bar
        painter: CaloricIntakePainter(
          progress: progress.clamp(0.0, 1.0),
          remainingCalories: remainingCalories,
          localization: S.of(context),
        ),
      ),
    );
  }
}
