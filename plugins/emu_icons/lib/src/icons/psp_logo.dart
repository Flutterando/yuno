import 'package:flutter/widgets.dart';

import '../classes.dart';

class PspLogo extends StatelessWidget {
  final double size;
  final Color? color;
  const PspLogo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: PspLogoPainter(color: color),
    );
  }
}

class PspLogoPainter extends CustomPainter {
  final Color? color;

  PspLogoPainter({
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

    _drawP1(canvas, dim, paint);
    _drawS(canvas, dim, paint);
    _drawP2(canvas, dim, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawP1(Canvas canvas, DimensionConvert dim, Paint paint) {
  final List<List<double>> p1 = [
    [00.00, 58.63], [00.00, 49.34], [29.98, 49.34], [29.98, 42.59], //
    [00.00, 42.59], [00.00, 41.37], [31.08, 41.37], [31.08, 50.55],
    [01.22, 50.55], [01.22, 58.63], [00.00, 58.63],
  ];

  final p1Path = Path()..addPolygon(genOffsetList(p1, dim), true);

  canvas.drawPath(p1Path, paint);
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

void _drawP2(Canvas canvas, DimensionConvert dim, Paint paint) {
  final List<List<double>> p2 = [
    [68.92, 58.63], [68.92, 49.34], [98.90, 49.34], [98.90, 42.59], //
    [68.92, 42.59], [68.92, 41.37], [100.0, 41.37], [100.0, 50.55],
    [70.13, 50.55], [70.13, 58.63], [68.92, 58.63],
  ];

  final p2Path = Path()..addPolygon(genOffsetList(p2, dim), true);

  canvas.drawPath(p2Path, paint);
}
