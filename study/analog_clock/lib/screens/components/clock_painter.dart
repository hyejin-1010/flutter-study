import 'dart:math';

import 'package:flutter/material.dart';

class ClickPainter extends CustomPainter {
  ClickPainter({
    required this.context,
    required this.dateTime,
  });
  final BuildContext context;
  final DateTime dateTime;

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);

    // Minute Calculation
    double minX = centerX + size.width * 0.35 * cos((dateTime.minute * 6) * pi / 180);
    double minY = centerY + size.width * 0.35 * sin((dateTime.minute * 6) * pi / 180);

    // Minute Line
    canvas.drawLine(
      center,
      Offset(minX, minY),
      Paint()
        ..color = Theme.of(context).accentColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );

    // Hour Calculation
    double hourX = centerX + size.width * 0.3 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = centerY + size.width * 0.3 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    // hour line
    canvas.drawLine(
      center,
      Offset(hourX, hourY),
      Paint()
        ..color = Theme.of(context).colorScheme.secondary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );

    // Second Calculation
    double secondX = centerX + size.width * 0.4 * cos((dateTime.second * 6) * pi / 180);
    double secondY = centerY + size.height * 0.4 * sin((dateTime.second * 6) * pi / 180);
    // Second Line
    canvas.drawLine(center, Offset(secondX, secondY), Paint()..color = Theme.of(context).primaryColor);

    // 시계 중심 동그라미 - Center Dots
    Paint dotPainter = Paint()
      ..color = Theme.of(context).primaryIconTheme.color!;
    canvas.drawCircle(center, 24, dotPainter);
    canvas.drawCircle(center, 23, Paint()..color = Theme.of(context).backgroundColor);
    canvas.drawCircle(center, 10, dotPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
