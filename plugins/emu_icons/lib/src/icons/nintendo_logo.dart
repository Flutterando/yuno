import 'package:flutter/widgets.dart';

import '../classes.dart';

class NintendoLogo extends StatelessWidget {
  final Color? color;
  final double size;
  const NintendoLogo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: NintendoLogoPainter(color: color),
    );
  }
}

class NintendoLogoPainter extends CustomPainter {
  final Color? color;

  NintendoLogoPainter({super.repaint, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    Color green = const Color(0xff6DB82B);
    Color yellow = const Color(0xffFDE000);
    Color blue = const Color(0xff00A6EA);
    Color red = const Color(0xffE50012);

    late final greenPaint = Paint();
    late final yellowPaint = Paint();
    late final bluePaint = Paint();
    late final redPaint = Paint();

    if (color != null) {
      greenPaint.color = color!;
      yellowPaint.color = color!;
      bluePaint.color = color!;
      redPaint.color = color!;
    } else {
      greenPaint.color = green;
      yellowPaint.color = yellow;
      bluePaint.color = blue;
      redPaint.color = red;
    }

    _drawRed(canvas, dim, redPaint);
    _drawBlue(canvas, dim, bluePaint);
    _drawGreen(canvas, dim, greenPaint);
    _drawYellow(canvas, dim, yellowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}

void _drawRed(Canvas canvas, DimensionConvert dim, Paint redPaint) {
  final rectOvalRed = Rect.fromLTRB(
    dim.w(63.22), dim.h(33.86), dim.w(100.0), dim.h(70.67), //
  );

  final rectCutOvalRed = Rect.fromLTRB(
    dim.w(46.14), dim.h(52.27), dim.w(82.26), dim.h(88.24), //
  );

  final redBallPath = Path()..addOval(rectOvalRed);
  final redCutBallPath = Path()..addOval(rectCutOvalRed);

  final cuttedRedPath = Path.combine(
    PathOperation.difference, redBallPath, redCutBallPath, //
  );

  canvas.drawPath(cuttedRedPath, redPaint);
}

void _drawGreen(Canvas canvas, DimensionConvert dim, Paint greenPaint) {
  final rectOvalGreen = Rect.fromLTRB(
    dim.w(00.00), dim.h(46.48), dim.w(39.88), dim.h(66.63), //
  );

  final greenBallPath = Path()..addOval(rectOvalGreen);

  canvas.drawPath(greenBallPath, greenPaint);
}

void _drawBlue(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final rectOvalBlue = Rect.fromLTRB(
    dim.w(25.90), dim.h(14.19), dim.w(63.51), dim.h(51.93), //
  );

  final rectCutOvalBlue = Rect.fromLTRB(
    dim.w(08.10), dim.h(32.84), dim.w(45.28), dim.h(70.93), //
  );

  final blueBallPath = Path()..addOval(rectOvalBlue);
  final blueCutBallPath = Path()..addOval(rectCutOvalBlue);

  final cuttedBluePath = Path.combine(
    PathOperation.difference, blueBallPath, blueCutBallPath, //
  );

  canvas.drawPath(cuttedBluePath, bluePaint);
}

void _drawYellow(Canvas canvas, DimensionConvert dim, Paint yellowPaint) {
  final rectOvalYellow = Rect.fromLTRB(
    dim.w(36.89), dim.h(64.65), dim.w(78.72), dim.h(85.87), //
  );

  final yellowBallPath = Path()..addOval(rectOvalYellow);

  canvas.drawPath(yellowBallPath, yellowPaint);
}
