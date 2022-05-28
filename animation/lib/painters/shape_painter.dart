import 'package:flutter/material.dart';

// TODO:
// 1. 먼저 원이 점차 커지며, 선이 얇아진다.
// 2. 체크 표시가 그려진다.

class ShapePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 80.0;

    double width = size.width;
    double height = size.height;
    double halfWidth = width / 2;
    double halfHeight = height / 2;
    Offset offset = Offset(halfWidth, halfHeight);

    // Draw Circle
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.redAccent
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(offset, radius, paint);

    double halfRadius = radius / 2;

    Offset startPoint = Offset(halfWidth - halfRadius, halfHeight - 10);
    Offset centerPoint = Offset(halfWidth - 10, halfHeight + halfRadius - 10);
    Offset endPoint = Offset(halfWidth + halfRadius, halfHeight - 20);
    canvas.drawLine(startPoint, centerPoint, paint);
    canvas.drawLine(centerPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
