import 'package:flutter/widgets.dart';

import '../classes.dart';

class Ps2Logo extends StatelessWidget {
  final Color? color;
  final double size;
  const Ps2Logo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: Ps2LogoPainter(color: color),
    );
  }
}

class Ps2LogoPainter extends CustomPainter {
  final Color? color;

  Ps2LogoPainter({
    super.repaint,
    this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);
    final paint = Paint();

    if (color != null) {
      paint.color = color!;
    } else {
      paint.shader = const LinearGradient(
          colors: [
            Color(0xff23BCEE),
            Color(0xff24B0E5),
            Color(0xff2785C3),
            Color(0xff2965AA),
            Color(0xff2B529B),
            Color(0xff2B4B96),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [
            00.00, 00.07, 00.36, 00.63, 00.85, 100.0, //
          ]).createShader(
        Rect.fromLTRB(
          dim.w(00.00), dim.h(41.37), dim.w(100.0), dim.h(58.63), //
        ),
      );
    }

    _drawP(canvas, dim, paint);
    _drawS(canvas, dim, paint);
    _draw2(canvas, dim, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawP(Canvas canvas, DimensionConvert dim, Paint paint) {
  final List<List<double>> p = [
    [00.00, 58.63], [00.00, 49.34], [29.98, 49.34], [29.98, 42.59], //
    [00.00, 42.59], [00.00, 41.37], [31.08, 41.37], [31.08, 50.55],
    [01.22, 50.55], [01.22, 58.63], [00.00, 58.63],
  ];

  final pPath = Path()..addPolygon(genOffsetList(p, dim), true);

  canvas.drawPath(pPath, paint);
}

void _drawS(Canvas canvas, DimensionConvert dim, Paint paint) {
  final List<List<double>> s = [
    [31.08, 58.63], [31.08, 57.41], [47.01, 57.41], [47.01, 41.37], //
    [64.16, 41.37], [64.16, 42.59], [48.34, 42.59], [48.34, 58.63],
    [31.08, 58.63],
  ];

  final sPath = Path()..addPolygon(genOffsetList(s, dim), true);

  canvas.drawPath(sPath, paint);
}

void _draw2(Canvas canvas, DimensionConvert dim, Paint paint) {
  final List<List<double>> two = [
    [68.80, 58.63], [68.80, 49.34], [98.78, 49.34], [98.78, 42.59], //
    [68.80, 42.59], [68.80, 41.37], [100.0, 41.37], [100.0, 50.55],
    [70.13, 50.55], [70.13, 57.41], [100.0, 57.41], [100.0, 58.63],
    [68.80, 58.63],
  ];

  final twoPath = Path()..addPolygon(genOffsetList(two, dim), true);

  canvas.drawPath(twoPath, paint);
}
