import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../classes.dart';

class SegaLogo extends StatelessWidget {
  final double size;
  final Color? color;
  final Color? borderColor;
  final Color? backgroundColor;
  const SegaLogo({
    super.key,
    this.size = 400,
    this.color,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SegaLogoPainter(
        color: color,
        borderColor: borderColor,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class _SegaLogoPainter extends CustomPainter {
  final Color? color;
  final Color? borderColor;
  final Color? backgroundColor;

  _SegaLogoPainter({
    this.color,
    this.borderColor,
    this.backgroundColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    const blue = Color(0xff0060A8);
    const contour = Color(0xffFFFFFF);
    const borderContour = Color(0xffCCCCCC);

    late final bluePaint = Paint();
    late final contourPaint = Paint();
    late final borderContourPaint = Paint()..style = PaintingStyle.stroke;

    if (color != null) {
      bluePaint.color = color!;
    } else {
      bluePaint.color = blue;
    }

    if (backgroundColor != null) {
      contourPaint.color = backgroundColor!;
      borderContourPaint.color = borderColor!;
    } else {
      contourPaint.color = contour;
      borderContourPaint.color = borderContour;
    }

    _drawContour(canvas, dim, contourPaint);
    _drawContour(canvas, dim, borderContourPaint);
    _drawS(canvas, dim, bluePaint);
    _drawE(canvas, dim, bluePaint);
    _drawG(canvas, dim, bluePaint);
    _drawA(canvas, dim, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}

void _drawContour(Canvas canvas, DimensionConvert dim, Paint contourPaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(00.00), dim.h(33.59), dim.w(23.01), dim.h(56.70), //
  );

  final pRecArc02 = Rect.fromLTRB(
    dim.w(00.00), dim.h(33.59), dim.w(23.01), dim.h(56.70), //
  );

  final pRecArc03 = Rect.fromLTRB(
    dim.w(23.68), dim.h(33.88), dim.w(43.58), dim.h(53.50), //
  );

  final pRecArc04 = Rect.fromLTRB(
    dim.w(46.35), dim.h(33.88), dim.w(66.25), dim.h(53.50), //
  );

  final pRecArc05 = Rect.fromLTRB(
    dim.w(74.05), dim.h(33.41), dim.w(91.24), dim.h(50.19), //
  );

  final pRecArc06 = Rect.fromLTRB(
    dim.w(46.35), dim.h(46.97), dim.w(66.25), dim.h(66.59), //
  );

  final pRecArc07 = Rect.fromLTRB(
    dim.w(23.68), dim.h(46.97), dim.w(43.58), dim.h(66.59), //
  );

  final pRecArc08 = Rect.fromLTRB(
    dim.w(05.65), dim.h(46.97), dim.w(25.55), dim.h(66.59), //
  );

  final contourPath = Path()
    ..moveTo(dim.w(00.00), dim.h(66.59))
    ..lineTo(dim.w(00.00), dim.h(53.23))
    ..lineTo(dim.w(03.31), dim.h(53.23))
    ..arcTo(
      pRecArc01,
      degreesToRadian(135.57),
      degreesToRadian(043.16),
      false,
    )
    ..arcTo(
      pRecArc02,
      degreesToRadian(179.81),
      degreesToRadian(090.19),
      false,
    )
    ..lineTo(dim.w(26.29), dim.h(33.88))
    ..lineTo(dim.w(26.29), dim.h(37.07))
    ..arcTo(
      pRecArc03,
      degreesToRadian(222.48),
      degreesToRadian(047.87),
      false,
    )
    ..lineTo(dim.w(49.29), dim.h(33.88))
    ..lineTo(dim.w(49.29), dim.h(36.72))
    ..arcTo(
      pRecArc04,
      degreesToRadian(225.17),
      degreesToRadian(044.83),
      false,
    )
    ..lineTo(dim.w(71.58), dim.h(33.87))
    ..lineTo(dim.w(71.58), dim.h(47.70))
    ..lineTo(dim.w(74.73), dim.h(38.54))
    ..arcTo(
      pRecArc05,
      degreesToRadian(202.86),
      degreesToRadian(133.97),
      false,
    )
    ..lineTo(dim.w(100.0), dim.h(66.59))
    ..lineTo(dim.w(56.30), dim.h(66.59))
    ..arcTo(
      pRecArc06,
      degreesToRadian(090.00),
      degreesToRadian(045.04),
      false,
    )
    ..lineTo(dim.w(49.27), dim.h(66.59))
    ..lineTo(dim.w(33.63), dim.h(66.59))
    ..arcTo(
      pRecArc07,
      degreesToRadian(090.00),
      degreesToRadian(064.97),
      false,
    )
    ..arcTo(
      pRecArc08,
      degreesToRadian(025.15),
      degreesToRadian(064.97),
      false,
    )
    ..lineTo(dim.w(00.00), dim.h(66.59));

  canvas.drawPath(contourPath, contourPaint);
}

void _drawS(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(09.51), dim.h(49.79), dim.w(20.09), dim.h(60.35), //
  );

  final pRecArc02 = Rect.fromLTRB(
    dim.w(07.17), dim.h(41.02), dim.w(15.90), dim.h(49.75), //
  );
  final pRecArc03 = Rect.fromLTRB(
    dim.w(11.07), dim.h(44.93), dim.w(11.99), dim.h(45.86), //
  );

  final pRecArc04 = Rect.fromLTRB(
    dim.w(05.61), dim.h(45.86), dim.w(24.03), dim.h(64.29), //
  );

  final pRecArc05 = Rect.fromLTRB(
    dim.w(14.32), dim.h(54.62), dim.w(15.22), dim.h(55.52), //
  );

  final pRecArc06 = Rect.fromLTRB(
    dim.w(02.28), dim.h(36.18), dim.w(20.73), dim.h(54.62), //
  );

  final pRecArc07 = Rect.fromLTRB(
    dim.w(06.24), dim.h(40.10), dim.w(16.80), dim.h(50.67), //
  );

  final pRecArc08 = Rect.fromLTRB(
    dim.w(10.45), dim.h(50.71), dim.w(19.17), dim.h(59.43), //
  );

  final path = Path()
    ..moveTo(dim.w(02.29), dim.h(64.30))
    ..lineTo(dim.w(02.29), dim.h(60.35))
    ..lineTo(dim.w(14.78), dim.h(60.35))
    ..arcTo(
      pRecArc01,
      degreesToRadian(090.0),
      -degreesToRadian(180.0),
      false,
    )
    ..lineTo(dim.w(11.53), dim.h(49.75))
    ..arcTo(
      pRecArc02,
      degreesToRadian(090.0),
      degreesToRadian(180.0),
      false,
    )
    ..lineTo(dim.w(24.01), dim.h(41.02))
    ..lineTo(dim.w(24.01), dim.h(44.93))
    ..lineTo(dim.w(11.54), dim.h(44.93))
    ..arcTo(
      pRecArc03,
      degreesToRadian(270.0),
      -degreesToRadian(180.0),
      false,
    )
    ..lineTo(dim.w(14.78), dim.h(45.86))
    ..arcTo(
      pRecArc04,
      degreesToRadian(270.0),
      degreesToRadian(180.0),
      false,
    )
    ..moveTo(dim.w(02.29), dim.h(59.43))
    ..lineTo(dim.w(02.29), dim.h(55.53))
    ..lineTo(dim.w(14.76), dim.h(55.52))
    ..arcTo(
      pRecArc05,
      degreesToRadian(090.0),
      -degreesToRadian(180.0),
      false,
    )
    ..lineTo(dim.w(11.50), dim.h(54.62))
    ..arcTo(
      pRecArc06,
      degreesToRadian(090.0),
      degreesToRadian(180.0),
      false,
    )
    ..lineTo(dim.w(24.01), dim.h(36.18))
    ..lineTo(dim.w(24.01), dim.h(40.10))
    ..lineTo(dim.w(11.53), dim.h(40.10))
    ..arcTo(
      pRecArc07,
      degreesToRadian(278.0),
      -degreesToRadian(180.0),
      false,
    )
    ..lineTo(dim.w(14.79), dim.h(50.71))
    ..arcTo(
      pRecArc08,
      degreesToRadian(270.0),
      degreesToRadian(180.0),
      false,
    );

  canvas.drawPath(path, bluePaint);
}

void _drawE(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(25.86), dim.h(48.60), dim.w(41.57), dim.h(64.28), //
  );

  final pRecArc02 = Rect.fromLTRB(
    dim.w(25.86), dim.h(36.18), dim.w(41.57), dim.h(51.85), //
  );

  final pRecArc03 = Rect.fromLTRB(
    dim.w(29.78), dim.h(40.10), dim.w(37.66), dim.h(47.83), //
  );

  final pRecArc04 = Rect.fromLTRB(
    dim.w(29.78), dim.h(52.64), dim.w(37.66), dim.h(60.37), //
  );

  final pRecArc05 = Rect.fromLTRB(
    dim.w(30.73), dim.h(53.46), dim.w(36.71), dim.h(59.42), //
  );

  final pRecArc06 = Rect.fromLTRB(
    dim.w(34.63), dim.h(53.67), dim.w(36.50), dim.h(55.52), //
  );

  final pRecArc07 = Rect.fromLTRB(
    dim.w(30.73), dim.h(41.01), dim.w(36.71), dim.h(46.97), //
  );

  final pRecArc08 = Rect.fromLTRB(
    dim.w(34.63), dim.h(44.91), dim.w(36.50), dim.h(46.76), //
  );

  final path = Path()
    ..moveTo(dim.w(47.00), dim.h(64.28))
    ..lineTo(dim.w(33.72), dim.h(64.28))
    ..arcTo(
      pRecArc01,
      degreesToRadian(090.0),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(25.86), dim.h(44.01))
    ..arcTo(
      pRecArc02,
      degreesToRadian(180.0),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(47.00), dim.h(36.18))
    ..lineTo(dim.w(47.00), dim.h(40.10))
    ..lineTo(dim.w(33.72), dim.h(40.10))
    ..arcTo(
      pRecArc03,
      degreesToRadian(270.0),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(29.78), dim.h(56.44))
    ..arcTo(
      pRecArc04,
      degreesToRadian(180.00),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(47.00), dim.h(60.37))
    //down E middle part
    ..moveTo(dim.w(47.00), dim.h(59.42))
    ..lineTo(dim.w(33.72), dim.h(59.42))
    ..arcTo(
      pRecArc05,
      degreesToRadian(090.00),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(30.73), dim.h(50.68))
    ..lineTo(dim.w(44.22), dim.h(50.68))
    ..lineTo(dim.w(44.22), dim.h(54.60))
    ..lineTo(dim.w(34.63), dim.h(54.60))
    ..arcTo(
      pRecArc06,
      degreesToRadian(180.00),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(47.00), dim.h(55.52))
    //up E middle part
    ..moveTo(dim.w(44.22), dim.h(49.75))
    ..lineTo(dim.w(30.73), dim.h(49.75))
    ..lineTo(dim.w(30.73), dim.h(44.00))
    ..arcTo(
      pRecArc07,
      degreesToRadian(180.00),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(47.05), dim.h(41.01))
    ..lineTo(dim.w(47.05), dim.h(44.93))
    ..lineTo(dim.w(35.56), dim.h(44.93))
    ..arcTo(
      pRecArc08,
      degreesToRadian(270.00),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(44.22), dim.h(45.85));
  canvas.drawPath(path, bluePaint);
}

void _drawG(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(48.50), dim.h(48.61), dim.w(64.27), dim.h(64.27), //
  );
  final pRecArc02 = Rect.fromLTRB(
    dim.w(48.50), dim.h(36.18), dim.w(64.27), dim.h(51.84), //
  );
  final pRecArc03 = Rect.fromLTRB(
    dim.w(52.47), dim.h(40.09), dim.w(60.30), dim.h(47.91), //
  );
  final pRecArc04 = Rect.fromLTRB(
    dim.w(52.47), dim.h(52.54), dim.w(60.30), dim.h(60.36), //
  );

  final pRecArc05 = Rect.fromLTRB(
    dim.w(53.39), dim.h(53.44), dim.w(59.38), dim.h(59.44), //
  );
  final pRecArc06 = Rect.fromLTRB(
    dim.w(53.39), dim.h(41.01), dim.w(59.38), dim.h(47.02), //
  );

  final pRecArc07 = Rect.fromLTRB(
    dim.w(57.29), dim.h(44.91), dim.w(59.14), dim.h(46.78), //
  );

  final pRecArc08 = Rect.fromLTRB(
    dim.w(57.30), dim.h(53.65), dim.w(59.14), dim.h(55.52), //
  );

  final path = Path()
    ..moveTo(dim.w(69.30), dim.h(64.28))
    ..lineTo(dim.w(56.39), dim.h(64.28))
    ..arcTo(
      pRecArc01,
      degreesToRadian(090.0),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(48.50), dim.h(44.00))
    ..arcTo(
      pRecArc02,
      degreesToRadian(180.0),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(69.30), dim.h(36.18))
    ..lineTo(dim.w(69.30), dim.h(40.10))
    ..lineTo(dim.w(56.39), dim.h(40.10))
    ..arcTo(
      pRecArc03,
      degreesToRadian(270.0),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(52.47), dim.h(56.44))
    ..arcTo(
      pRecArc04,
      degreesToRadian(180.0),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(65.38), dim.h(60.36))
    ..lineTo(dim.w(65.38), dim.h(49.75))
    ..lineTo(dim.w(58.20), dim.h(49.75))
    ..lineTo(dim.w(58.20), dim.h(45.85))
    ..lineTo(dim.w(69.30), dim.h(45.85))

    //inner G
    ..moveTo(dim.w(64.45), dim.h(59.44))
    ..lineTo(dim.w(56.39), dim.h(59.44))
    ..arcTo(
      pRecArc05,
      degreesToRadian(090.0),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(53.39), dim.h(44.00))
    ..arcTo(
      pRecArc06,
      degreesToRadian(180.0),
      degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(69.30), dim.h(41.01))
    ..lineTo(dim.w(69.30), dim.h(44.91))
    ..lineTo(dim.w(58.22), dim.h(44.91))
    ..arcTo(
      pRecArc07,
      degreesToRadian(270.0),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(57.30), dim.h(54.58))
    ..arcTo(
      pRecArc08,
      degreesToRadian(180.0),
      -degreesToRadian(090.0),
      false,
    )
    ..lineTo(dim.w(60.53), dim.h(55.52))
    ..lineTo(dim.w(60.53), dim.h(54.60))
    ..lineTo(dim.w(58.21), dim.h(54.60))
    ..lineTo(dim.w(58.21), dim.h(50.68))
    ..lineTo(dim.w(64.45), dim.h(50.68));
  canvas.drawPath(path, bluePaint);
}

void _drawA(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(76.61), dim.h(35.72), dim.w(88.67), dim.h(45.72), //
  );

  final pRecArc02 = Rect.fromLTRB(
    dim.w(80.53), dim.h(39.19), dim.w(84.74), dim.h(42.97), //
  );

  final pRecArc03 = Rect.fromLTRB(
    dim.w(81.41), dim.h(40.09), dim.w(83.88), dim.h(42.29), //
  );
  final path = Path()
    ..moveTo(dim.w(68.38), dim.h(64.27))
    ..lineTo(dim.w(76.71), dim.h(39.84))
    ..arcTo(
      pRecArc01,
      degreesToRadian(190.37),
      degreesToRadian(159.37),
      false,
    )
    ..lineTo(dim.w(96.83), dim.h(64.27))
    ..lineTo(dim.w(80.95), dim.h(64.27))
    ..lineTo(dim.w(80.95), dim.h(60.36))
    ..lineTo(dim.w(91.38), dim.h(60.36))
    ..lineTo(dim.w(84.65), dim.h(40.52))
    ..arcTo(
      pRecArc02,
      -degreesToRadian(037.07),
      -degreesToRadian(108.91), //145.98
      false,
    )
    ..lineTo(dim.w(72.53), dim.h(64.27))

    //inner A
    ..moveTo(dim.w(73.51), dim.h(64.27))
    ..lineTo(dim.w(81.44), dim.h(40.95))
    ..arcTo(
      pRecArc03,
      degreesToRadian(192.67),
      degreesToRadian(154.66),
      false,
    )
    ..lineTo(dim.w(90.12), dim.h(59.47))
    ..lineTo(dim.w(80.94), dim.h(59.47))
    ..lineTo(dim.w(80.94), dim.h(55.11))
    ..lineTo(dim.w(84.02), dim.h(55.11))
    ..lineTo(dim.w(82.64), dim.h(51.01))
    ..lineTo(dim.w(78.14), dim.h(64.27));
  canvas.drawPath(path, bluePaint);
}
