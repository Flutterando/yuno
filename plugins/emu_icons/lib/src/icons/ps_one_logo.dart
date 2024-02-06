import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../classes.dart';

class PsOneLogo extends StatelessWidget {
  final double size;
  final Color? color;
  const PsOneLogo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PsOneLogoPainter(color: color),
    );
  }
}

class _PsOneLogoPainter extends CustomPainter {
  final Color? color;

  _PsOneLogoPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    Color red = const Color(0xffDE0029);
    Color blue = const Color(0xff326DB3);
    Color green = const Color(0xff00AA9E);
    Color yellow = const Color(0xffF3C202);

    late final redPaint = Paint();
    late final bluePaint = Paint();
    late final greenPaint = Paint();
    late final yellowPaint = Paint();

    if (color != null) {
      redPaint.color = color!;
      bluePaint.color = color!;
      greenPaint.color = color!;
      yellowPaint.color = color!;
    } else {
      redPaint.color = red;
      bluePaint.color = blue;
      greenPaint.color = green;
      yellowPaint.color = yellow;
    }

    _drawP(canvas, dim, redPaint);
    _drawGreenPath(canvas, dim, greenPaint);
    _drawYellowPath(canvas, dim, yellowPaint);
    _drawBluePath(canvas, dim, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}

void _drawP(Canvas canvas, DimensionConvert dim, Paint redPaint) {
  final Path pPath = Path()
    ..moveTo(dim.w(37.77), dim.h(82.74))
    ..lineTo(dim.w(37.77), dim.h(12.01))
    ..lineTo(dim.w(60.18), dim.h(17.98))
    ..quadraticBezierTo(
      dim.w(78.78), dim.h(23.00), dim.w(79.45), dim.h(39.94), //
    )
    ..quadraticBezierTo(
      dim.w(78.80), dim.h(54.84), dim.w(67.55), dim.h(57.02), //
    )
    ..quadraticBezierTo(
      dim.w(64.87), dim.h(57.50), dim.w(60.18), dim.h(55.93), //
    )
    ..lineTo(dim.w(60.18), dim.h(27.41))
    ..quadraticBezierTo(
      dim.w(59.50), dim.h(25.80), dim.w(57.07), dim.h(25.62), //
    )
    ..quadraticBezierTo(
      dim.w(54.55), dim.h(25.62), dim.w(53.95), dim.h(27.41), //
    )
    ..lineTo(dim.w(53.89), dim.h(87.99));

  canvas.drawPath(pPath, redPaint);
}

void _drawGreenPath(Canvas canvas, DimensionConvert dim, Paint greenPaint) {
  final greenPath = Path()
    ..moveTo(dim.w(68.11), dim.h(83.07))
    ..lineTo(dim.w(53.89), dim.h(78.55))
    ..lineTo(dim.w(53.89), dim.h(77.76))
    ..lineTo(dim.w(76.31), dim.h(70.09))
    ..lineTo(dim.w(91.51), dim.h(74.81))
    ..lineTo(dim.w(68.11), dim.h(83.07))
    ..moveTo(dim.w(53.92), dim.h(72.45))
    ..lineTo(dim.w(53.92), dim.h(63.08))
    ..lineTo(dim.w(68.24), dim.h(67.54))
    ..lineTo(dim.w(53.94), dim.h(72.45))
    ..moveTo(dim.w(37.77), dim.h(73.43))
    ..lineTo(dim.w(30.36), dim.h(71.07))
    ..lineTo(dim.w(37.77), dim.h(68.58))
    ..moveTo(dim.w(21.84), dim.h(68.39))
    ..lineTo(dim.w(08.01), dim.h(63.93))
    ..lineTo(dim.w(31.41), dim.h(56.13))
    ..lineTo(dim.w(37.77), dim.h(58.10))
    ..lineTo(dim.w(37.77), dim.h(62.68));

  canvas.drawPath(greenPath, greenPaint);
}

void _drawYellowPath(Canvas canvas, DimensionConvert dim, Paint yellowPaint) {
  final yellowPath = Path()
    ..moveTo(dim.w(53.89), dim.h(87.66))
    ..lineTo(dim.w(53.89), dim.h(78.55))
    ..lineTo(dim.w(68.11), dim.h(83.07))
    ..lineTo(dim.w(53.89), dim.h(87.99))
    ..moveTo(dim.w(37.77), dim.h(77.96))
    ..quadraticBezierTo(
      dim.w(30.68),
      dim.h(79.84),
      dim.w(24.21),
      dim.h(80.11),
    )
    ..quadraticBezierTo(
      dim.w(19.16),
      dim.h(80.00),
      dim.w(18.04),
      dim.h(79.80),
    )
    ..quadraticBezierTo(
      dim.w(00.00),
      dim.h(78.86),
      dim.w(00.00),
      dim.h(72.85),
    )
    ..quadraticBezierTo(
      dim.w(00.00),
      dim.h(67.11),
      dim.w(08.01),
      dim.h(63.93),
    )
    ..lineTo(dim.w(21.84), dim.h(68.39))
    ..lineTo(dim.w(18.16), dim.h(69.70))
    ..quadraticBezierTo(
      dim.w(16.30),
      dim.h(70.36),
      dim.w(16.22),
      dim.h(71.63),
    )
    ..quadraticBezierTo(
      dim.w(16.50),
      dim.h(73.50),
      dim.w(20.04),
      dim.h(74.04),
    )
    ..quadraticBezierTo(
      dim.w(21.86),
      dim.h(74.00),
      dim.w(22.75),
      dim.h(73.63),
    )
    ..lineTo(dim.w(30.36), dim.h(71.07))
    ..lineTo(dim.w(37.77), dim.h(73.43));

  canvas.drawPath(yellowPath, yellowPaint);
}

void _drawBluePath(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final bluePath = Path()
    ..moveTo(dim.w(91.51), dim.h(74.81))
    ..lineTo(dim.w(76.31), dim.h(70.09))
    ..quadraticBezierTo(
      dim.w(85.90),
      dim.h(67.13),
      dim.w(85.31),
      dim.h(65.62),
    )
    ..quadraticBezierTo(
      dim.w(84.54),
      dim.h(64.46),
      dim.w(81.35),
      dim.h(64.24),
    )
    ..quadraticBezierTo(
      dim.w(78.50),
      dim.h(64.20),
      dim.w(76.63),
      dim.h(64.72),
    )
    ..lineTo(dim.w(68.24), dim.h(67.54))
    ..lineTo(dim.w(53.89), dim.h(63.09))
    ..quadraticBezierTo(
      dim.w(64.29),
      dim.h(59.20),
      dim.w(77.05),
      dim.h(59.51),
    )
    ..quadraticBezierTo(
      dim.w(98.05),
      dim.h(60.56),
      dim.w(100.0),
      dim.h(67.50),
    )
    ..quadraticBezierTo(
      dim.w(100.0),
      dim.h(71.77),
      dim.w(91.77),
      dim.h(74.75),
    )
    ..moveTo(dim.w(37.77), dim.h(58.10))
    ..lineTo(dim.w(31.41), dim.h(56.13))
    ..lineTo(dim.w(37.77), dim.h(53.97));

  canvas.drawPath(bluePath, bluePaint);
}
