import 'dart:math';
import 'package:flutter/material.dart';

class CookieAnimation extends StatefulWidget {
  const CookieAnimation({super.key});

  @override
  CookieAnimationState createState() => CookieAnimationState();
}

class CookieAnimationState extends State<CookieAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color borderColor = theme.colorScheme.secondary;
    final Color cookieColor = theme.colorScheme.primary;
    final Color chocolateColor = theme.textTheme.bodyLarge!.color!;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CookiePainter(
            animationValue: _controller.value,
            borderColor: borderColor,
            cookieColor: cookieColor,
            chocolateColor: chocolateColor,
          ),
          child: Container(),
        );
      },
    );
  }
}

class CookiePainter extends CustomPainter {
  final double animationValue;
  final Color borderColor;
  final Color cookieColor;
  final Color chocolateColor;

  CookiePainter({
    required this.animationValue,
    required this.borderColor,
    required this.cookieColor,
    required this.chocolateColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double cookieDiameter = 100;
    const double cookieRadius = cookieDiameter / 2;

    final double translateX = (size.width - cookieDiameter) * animationValue;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final Paint cookiePaint = Paint()
      ..color = cookieColor
      ..style = PaintingStyle.fill;

    final Paint chocolatePaint = Paint()
      ..color = chocolateColor
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(translateX + cookieRadius, size.height / 2);

    final double rotationAngle = animationValue * 2 * pi;
    canvas.rotate(rotationAngle);

    canvas.drawCircle(Offset.zero, cookieRadius + 2, borderPaint);
    canvas.drawCircle(Offset.zero, cookieRadius, cookiePaint);

    const int numChocolatePieces = 10;
    final Random random = Random(1);
    const double angleIncrement = 2 * pi / numChocolatePieces;
    const double ringRadius = cookieRadius - 15;

    for (int i = 0; i < numChocolatePieces; i++) {
      final double angle = i * angleIncrement;
      final double x = ringRadius * cos(angle);
      final double y = ringRadius * sin(angle);
      final double chocolateSize = 4 + random.nextDouble() * (8 - 4);
      canvas.drawCircle(Offset(x, y), chocolateSize, chocolatePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}