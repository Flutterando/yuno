import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../classes.dart';

class PsVitaLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const PsVitaLogo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PsVitaLogoPainter(
        color: color,
      ),
    );
  }
}

class _PsVitaLogoPainter extends CustomPainter {
  final Color? color;

  _PsVitaLogoPainter({
    this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    const black = Color(0xff000000);

    late final blackPaint = Paint();

    if (color != null) {
      blackPaint.color = color!;
    } else {
      blackPaint.color = black;
    }

    _drawP(canvas, dim, blackPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}

void _drawP(Canvas canvas, DimensionConvert dim, Paint blackPaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(00.00), dim.h(48.67), dim.w(08.17), dim.h(57.31), //
  );

  final pRecArc02 = Rect.fromLTRB(
    dim.w(10.53), dim.h(44.47), dim.w(14.67), dim.h(48.67), //
  );

  final pRecArc03 = Rect.fromLTRB(
    dim.w(10.53), dim.h(43.78), dim.w(14.67), dim.h(47.98), //
  );

  final pRecArc04 = Rect.fromLTRB(
    dim.w(09.41), dim.h(41.74), dim.w(18.07), dim.h(49.85), //
  );

  final pRecArc05 = Rect.fromLTRB(
    dim.w(09.41), dim.h(42.77), dim.w(18.07), dim.h(50.88), //
  );

  final pRecArc06 = Rect.fromLTRB(
    dim.w(03.42), dim.h(50.88), dim.w(06.97), dim.h(55.12), //
  );

  final contourPath = Path()
        ..moveTo(dim.w(00.00), dim.h(58.29))
        ..lineTo(dim.w(00.00), dim.h(53.00))
        ..arcTo(
          pRecArc01,
          degreesToRadian(180.00),
          degreesToRadian(090.00),
          false,
        )
        ..lineTo(dim.w(12.60), dim.h(48.67))
        ..arcTo(
          pRecArc02,
          degreesToRadian(090.00),
          -degreesToRadian(090.00),
          false,
        )
        ..lineTo(dim.w(14.67), dim.h(45.88))
        ..arcTo(
          pRecArc03,
          degreesToRadian(000.00),
          -degreesToRadian(090.00),
          false,
        )
        ..lineTo(dim.w(00.00), dim.h(43.78))
        ..lineTo(dim.w(00.00), dim.h(41.74))
        ..lineTo(dim.w(13.74), dim.h(41.74))
        ..arcTo(
          pRecArc04,
          degreesToRadian(270.00),
          degreesToRadian(090.00),
          false,
        )
        ..lineTo(dim.w(18.07), dim.h(46.83))
        ..arcTo(
          pRecArc05,
          degreesToRadian(000.00),
          degreesToRadian(090.00),
          false,
        )
        ..lineTo(dim.w(05.19), dim.h(50.88))
        ..arcTo(
          pRecArc06,
          degreesToRadian(270.00),
          -degreesToRadian(090.00),
          false,
        )
        ..lineTo(dim.w(03.42), dim.h(58.29))
      //
      ;

  canvas.drawPath(contourPath, blackPaint);
}

void _drawS(Canvas canvas, DimensionConvert dim, Paint blackPaint) {}
void _drawV(Canvas canvas, DimensionConvert dim, Paint blackPaint) {}
void _drawI(Canvas canvas, DimensionConvert dim, Paint blackPaint) {}
void _drawT(Canvas canvas, DimensionConvert dim, Paint blackPaint) {}
void _drawA(Canvas canvas, DimensionConvert dim, Paint blackPaint) {}
