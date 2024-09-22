import 'package:flutter/material.dart';

class NutrientIntakePainter extends CustomPainter {
  NutrientIntakePainter({
    required this.currentValue,
    required this.goalValue,
  });

  final double currentValue;
  final double goalValue;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBackground = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final Paint paintProgress = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final BorderRadius borderRadius = BorderRadius.circular(14);

    // Draw background
    final RRect rrectBackground = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );
    canvas.drawRRect(rrectBackground, paintBackground);

    // Calculate progress and draw it
    final double progressWidth =
        (currentValue / goalValue).clamp(0.0, 1.0) * size.width;
    final rrectProgress = RRect.fromRectAndCorners(
      Rect.fromLTWH(1, 1, progressWidth, size.height - 2),
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );
    canvas.drawRRect(rrectProgress, paintProgress);
  }

  @override
  bool shouldRepaint(NutrientIntakePainter oldDelegate) {
    return oldDelegate.currentValue != currentValue ||
        oldDelegate.goalValue != goalValue;
  }
}

class NutrientIntakeWidget extends StatelessWidget {
  const NutrientIntakeWidget({
    super.key,
    required this.label,
    required this.currentValue,
    required this.goalValue,
  });

  final String label;
  final double currentValue;
  final double goalValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        CustomPaint(
          size: const Size(80, 6.6), // You can adjust the size
          painter: NutrientIntakePainter(
            currentValue: currentValue,
            goalValue: goalValue,
          ),
        ),
      ],
    );
  }
}
