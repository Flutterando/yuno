import 'package:flutter/widgets.dart';

import '../classes.dart';

class N64Logo extends StatelessWidget {
  final double size;
  final Color? color;
  const N64Logo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _N64LogoPainter(color: color),
    );
  }
}

class _N64LogoPainter extends CustomPainter {
  final Color? color;

  _N64LogoPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    const Color yellow = Color(0xffFFC001);
    const Color green = Color(0xff069330);
    const Color blue = Color(0xff011DA9);
    const Color red = Color(0xffFE2015);

    late final yellowPaint = Paint();
    late final greenPaint = Paint();
    late final bluePaint = Paint();
    late final redPaint = Paint();

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

    final List<List<double>> greenN = [
      [00.00, 78.87], [00.00, 19.27], [14.22, 24.72], [35.02, 64.00], //
      [35.02, 32.82], [50.10, 38.54], [50.10, 100.0], [35.02, 93.62],
      [14.22, 53.28], [14.22, 84.85], [00.00, 78.87],
    ];

    final List<List<double>> blueN = [
      [50.03, 100.0], [50.03, 38.54], [65.05, 32.82], [85.85, 62.59], //
      [85.85, 24.72], [100.0, 19.27], [100.0, 78.87], [85.85, 84.85],
      [65.05, 57.67], [65.05, 93.62], [50.03, 100.0],
    ];

    final List<List<double>> yellow1 = [
      [00.00, 19.27], [14.22, 13.82], [28.37, 19.27], [14.15, 24.72], //
    ];
    final List<List<double>> yellow2 = [
      [36.08, 05.45], [50.03, 00.05], [64.00, 05.52], [50.03, 10.90], //
    ];
    final List<List<double>> yellow3 = [
      [71.70, 19.27], [85.85, 13.82], [100.0, 19.27], [85.85, 24.72], //
    ];
    final List<List<double>> yellow4 = [
      [35.08, 32.82], [50.10, 27.11], [65.12, 32.82], [50.03, 38.54], //
    ];

    final List<List<double>> green1 = [
      [35.08, 32.82], [28.37, 19.27], [36.08, 05.45], [50.03, 10.90], //
      [38.47, 31.49],
    ];

    final List<List<double>> green2 = [
      [65.06, 32.84], [61.06, 31.30], [71.69, 19.27], [85.85, 24.72], //
      [85.85, 62.59],
    ];

    final List<List<double>> blue1 = [
      [14.22, 84.85], [14.15, 53.16], [27.46, 78.96], //
    ];

    final List<List<double>> blue2 = [
      [38.47, 31.49], [50.03, 10.90], [63.99, 05.51], [64.00, 27.97], //
      [61.06, 31.30], [50.10, 27.11],
    ];

    final List<List<double>> red1 = [
      [35.02, 64.00], [14.22, 24.72], [28.37, 19.27], [35.08, 32.82], //
    ];

    final List<List<double>> red2 = [
      [69.30, 78.47], [65.05, 72.49], [65.05, 57.67], [85.85, 84.85], //
    ];

    final greenNPath = Path()..addPolygon(genOffsetList(greenN, dim), true);
    final green1Path = Path()..addPolygon(genOffsetList(green1, dim), true);
    final green2Path = Path()..addPolygon(genOffsetList(green2, dim), true);
    final blueNPath = Path()..addPolygon(genOffsetList(blueN, dim), true);
    final blue1Path = Path()..addPolygon(genOffsetList(blue1, dim), true);
    final blue2Path = Path()..addPolygon(genOffsetList(blue2, dim), true);
    final yellow1Path = Path()..addPolygon(genOffsetList(yellow1, dim), true);
    final yellow2Path = Path()..addPolygon(genOffsetList(yellow2, dim), true);
    final yellow3Path = Path()..addPolygon(genOffsetList(yellow3, dim), true);
    final yellow4Path = Path()..addPolygon(genOffsetList(yellow4, dim), true);
    final red1Path = Path()..addPolygon(genOffsetList(red1, dim), true);
    final red2Path = Path()..addPolygon(genOffsetList(red2, dim), true);

    canvas.drawPath(greenNPath, greenPaint);
    canvas.drawPath(green1Path, greenPaint);
    canvas.drawPath(green2Path, greenPaint);
    canvas.drawPath(blueNPath, bluePaint);
    canvas.drawPath(blue1Path, bluePaint);
    canvas.drawPath(blue2Path, bluePaint);
    canvas.drawPath(yellow1Path, yellowPaint);
    canvas.drawPath(yellow2Path, yellowPaint);
    canvas.drawPath(yellow3Path, yellowPaint);
    canvas.drawPath(yellow4Path, yellowPaint);
    canvas.drawPath(red1Path, redPaint);
    canvas.drawPath(red2Path, redPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}
