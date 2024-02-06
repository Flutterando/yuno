import 'package:flutter/widgets.dart';

import '../classes.dart';

class SwitchLogo extends StatelessWidget {
  final Color? color;
  final double size;
  const SwitchLogo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SwitchLogoPainter(color: color),
    );
  }
}

class _SwitchLogoPainter extends CustomPainter {
  final Color? color;

  _SwitchLogoPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);
    const red = Color(0xFFE70012);

    final backPaint = Paint();

    if (color != null) {
      backPaint.color = color!;
    } else {
      backPaint.color = red;
    }

    final rectBack = RRect.fromLTRBR(
      dim.w(00.00),
      dim.h(00.00),
      dim.w(100.0),
      dim.h(100.0),
      Radius.circular(dim.h(27.00)),
    );
    final backPath = Path()..addRRect(rectBack);

    final leftCutRRect = RRect.fromLTRBAndCorners(
      dim.w(08.50),
      dim.h(08.50),
      dim.w(40.28),
      dim.h(91.50),
      topLeft: Radius.circular(dim.h(17.50)),
      bottomLeft: Radius.circular(dim.h(17.50)),
    );

    final leftCutPath = Path()..addRRect(leftCutRRect);

    final ovalLeftRect = Rect.fromLTRB(
      dim.w(16.00),
      dim.h(21.00),
      dim.w(34.50),
      dim.h(39.50),
    );

    final leftBallCutPath = Path()..addOval(ovalLeftRect);

    final middleRect = Rect.fromLTRB(
      dim.w(48.50),
      dim.h(00.00),
      dim.w(58.50),
      dim.h(100.00),
    );

    final middleCutPath = Path()..addRect(middleRect);

    final ovalRightCutRect = Rect.fromLTRB(
      dim.w(68.00),
      dim.h(45.00),
      dim.w(88.00),
      dim.h(65.00),
    );

    final rightBallCuttPath = Path()..addOval(ovalRightCutRect);

    final auxLeftCutPath = Path.combine(
      PathOperation.difference,
      backPath,
      leftCutPath,
    );

    final auxMiddleCutPath = Path.combine(
      PathOperation.difference,
      auxLeftCutPath,
      middleCutPath,
    );

    final auxRightBallCuttPath = Path.combine(
      PathOperation.difference,
      auxMiddleCutPath,
      rightBallCuttPath,
    );

    canvas.drawPath(auxRightBallCuttPath, backPaint);
    canvas.drawPath(leftBallCutPath, backPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}
