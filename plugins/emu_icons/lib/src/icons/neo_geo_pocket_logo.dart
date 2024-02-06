import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../classes.dart';

class NeoGeoPocketLogo extends StatelessWidget {
  final double size;
  final Color? color;
  const NeoGeoPocketLogo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NeoGeoPocketLogoPainter(color: color),
    );
  }
}

class _NeoGeoPocketLogoPainter extends CustomPainter {
  final Color? color;

  _NeoGeoPocketLogoPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    Color red = const Color(0xffE81A2E);
    Color blue = const Color(0xff00ADF7);
    Color green = const Color(0xff008C84);

    late final redPaint = Paint();
    late final bluePaint = Paint();
    late final greenPaint = Paint();

    if (color != null) {
      redPaint.color = color!;
      bluePaint.color = color!;
      greenPaint.color = color!;
    } else {
      redPaint.color = red;
      bluePaint.color = blue;
      greenPaint.color = green;
    }

    _drawP(canvas, dim, redPaint);
    _drawRedTrace(canvas, dim, redPaint);
    _drawGreenTrace(canvas, dim, greenPaint);
    _drawBlueTrace(canvas, dim, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}

void _drawP(Canvas canvas, DimensionConvert dim, Paint redPaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(24.06), dim.h(27.46), dim.w(68.11), dim.h(69.08), //
  );

  final pRecArc02 = Rect.fromLTRB(
    dim.w(24.48), dim.h(27.46), dim.w(67.69), dim.h(69.08), //
  );

  final pRecArc03 = Rect.fromLTRB(
    dim.w(27.69), dim.h(27.97), dim.w(67.69), dim.h(69.63), //
  );

  final pRecArc04 = Rect.fromLTRB(
    dim.w(16.00), dim.h(20.67), dim.w(68.15), dim.h(72.67), //
  );

  final pRecArc05 = Rect.fromLTRB(
    dim.w(25.89), dim.h(34.00), dim.w(60.21), dim.h(64.67), //
  );
  final pRecArc06 = Rect.fromLTRB(
    dim.w(25.89), dim.h(34.00), dim.w(60.21), dim.h(64.67), //
  );

  final pRecArc07 = Rect.fromLTRB(
    dim.w(32.58),
    dim.h(35.32),
    dim.w(59.42),
    dim.h(57.84),
  );

  final Path pPath = Path()
    ..moveTo(dim.w(40.69), dim.h(100.0))
    ..lineTo(dim.w(11.79), dim.h(41.77))
    ..lineTo(dim.w(35.83), dim.h(29.84))
    ..arcTo(
      pRecArc01,
      degreesToRadian(242.27),
      degreesToRadian(027.73),
      false,
    )
    ..arcTo(
      pRecArc02,
      degreesToRadian(270.0),
      degreesToRadian(90.00),
      false,
    )
    ..arcTo(
      pRecArc03,
      degreesToRadian(358.54),
      degreesToRadian(15.21),
      false,
    )
    ..arcTo(
      pRecArc04,
      degreesToRadian(18.16),
      degreesToRadian(56.02),
      false,
    )
    ..lineTo(dim.w(30.78), dim.h(57.14))
    ..lineTo(dim.w(36.63), dim.h(40.29))
    ..lineTo(dim.w(52.15), dim.h(40.29))
    ..lineTo(dim.w(52.15), dim.h(47.89))
    ..lineTo(dim.w(42.04), dim.h(47.81))
    ..lineTo(dim.w(39.94), dim.h(55.56))
    ..lineTo(dim.w(50.46), dim.h(63.17))
    ..arcTo(
      pRecArc05,
      degreesToRadian(64.43),
      -degreesToRadian(57.83),
      false,
    )
    ..arcTo(
      pRecArc06,
      degreesToRadian(06.60),
      -degreesToRadian(56.49),
      false,
    )
    ..arcTo(
      pRecArc07,
      -degreesToRadian(56.49),
      -degreesToRadian(70.10),
      false,
    )
    ..lineTo(dim.w(38.82), dim.h(37.04))
    ..lineTo(dim.w(21.87), dim.h(45.42))
    ..lineTo(dim.w(47.32), dim.h(96.71));

  canvas.drawPath(pPath, redPaint);
}

void _drawRedTrace(Canvas canvas, DimensionConvert dim, Paint redPaint) {
  final redPath = Path()
    ..moveTo(dim.w(47.47), dim.h(20.04))
    ..lineTo(dim.w(50.17), dim.h(00.00))
    ..lineTo(dim.w(59.66), dim.h(01.39))
    ..lineTo(dim.w(52.55), dim.h(21.02));
  canvas.drawPath(redPath, redPaint);
}

void _drawGreenTrace(Canvas canvas, DimensionConvert dim, Paint greenPaint) {
  final greenPath = Path()
    ..moveTo(dim.w(60.07), dim.h(23.64))
    ..lineTo(dim.w(70.05), dim.h(06.30))
    ..lineTo(dim.w(77.08), dim.h(11.29))
    ..lineTo(dim.w(64.49), dim.h(26.58));

  canvas.drawPath(greenPath, greenPaint);
}

void _drawBlueTrace(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final bluePath = Path()
    ..moveTo(dim.w(68.90), dim.h(31.24))
    ..lineTo(dim.w(83.38), dim.h(18.32))
    ..lineTo(dim.w(88.20), dim.h(26.25))
    ..lineTo(dim.w(72.26), dim.h(36.23));

  canvas.drawPath(bluePath, bluePaint);
}
