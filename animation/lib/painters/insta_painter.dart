import 'dart:math';

import 'package:flutter/material.dart';

const maxRadius = 80.0;

class InstaPainter extends CustomPainter {
  final double value;

  InstaPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double halfWidth = width / 2;
    double halfHeight = height / 2;
    Offset offset = Offset(halfWidth, halfHeight);

    double circleAnimationValue = value * 2;
    double strokeWidth = 6 + max((1 - circleAnimationValue) * 6, 0);
    double radius = 1 + min(circleAnimationValue * maxRadius, maxRadius);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..shader = const RadialGradient(
        colors: [Colors.redAccent, Colors.orange],
      ).createShader(Rect.fromCircle(
        center: offset,
        radius: radius,
      ))
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(offset, radius, paint);

    if (value >= 0.5) {
      double halfRadius = maxRadius / 2;

      double startX = halfWidth - halfRadius;
      double startY = halfHeight - 10;

      Offset startPoint = Offset(startX, startY);
      double centerX = halfWidth - 10;
      double centerY = halfHeight + halfRadius - 10;
      double endX = halfWidth + halfRadius;
      double endY = halfHeight - 20;

      double centerAnimationValue = (value - 0.5) * 4;
      if (centerAnimationValue > 1.0) { centerAnimationValue = 1.0; }
      double startCenterDiffX = centerX - startX;
      double startCenterDiffY = centerY - startY;
      Offset centerPoint = Offset(startX + startCenterDiffX * centerAnimationValue, startY + startCenterDiffY * centerAnimationValue);
      canvas.drawLine(startPoint, centerPoint, paint);

      if (value >= 0.75) {
        double animationValue = (value - 0.75) * 4;
        double centerEndDiffX = endX - centerX;
        double centerEndDiffY = centerY - endY;
        Offset endPoint = Offset(centerX + centerEndDiffX * animationValue, centerY - centerEndDiffY * animationValue);
        canvas.drawLine(centerPoint, endPoint, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}