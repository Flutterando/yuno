import 'package:flutter/widgets.dart';

import '../classes.dart';

class NeoGeoCDLogo extends StatelessWidget {
  final double size;
  const NeoGeoCDLogo({
    super.key,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NeoGeoCDLogoPainter(),
    );
  }
}

class _NeoGeoCDLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    Color yellow = const Color(0xffFFC011);
    Color black = const Color(0xff000000);
    Color blue = const Color(0xff00A2E7);

    final yellowPaint = Paint()..color = yellow;
    final blackPaint = Paint()..color = black;
    final bluePaint = Paint()..color = blue;

    _drawC(canvas, dim, blackPaint, yellowPaint);
    _drawD(canvas, dim, blackPaint, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawC(
  Canvas canvas,
  DimensionConvert dim,
  Paint blackPaint,
  Paint yellowPaint,
) {
  final List<List<double>> cBlackPoints = [
    [20.68, 83.15], [00.00, 62.23], [00.00, 34.02], [17.17, 16.90], //
    [35.29, 34.97], [35.80, 51.15], [52.03, 51.65], [66.15, 65.73],
    [48.98, 83.15], [20.68, 83.15],
  ];

  final List<List<double>> cYellowPoints = [
    [21.51, 81.14], [01.97, 61.40], [01.97, 34.85], [17.17, 19.73], //
    [35.39, 37.89], [35.80, 51.15], [52.03, 51.65], [64.73, 64.32],
    [48.16, 81.15], [21.51, 81.14],
  ];

  final List<List<double>> eLCPoints = [
    [12.54, 52.08], [10.85, 51.55], [10.74, 49.79], [12.16, 48.59], //
    [14.87, 49.34], [14.85, 51.34], [12.54, 52.08],
  ];

  final List<List<double>> eRCPoints = [
    [23.49, 45.21], [21.66, 43.06], [23.44, 38.82], [26.24, 39.35], //
    [28.00, 42.41], [26.59, 45.18], [23.49, 45.21],
  ];

  final List<List<double>> mCPoints = [
    [27.29, 73.24], [23.40, 70.30], [26.66, 71.49], [32.80, 71.35], //
    [37.25, 67.07], [39.64, 63.85], [40.73, 57.56], [40.99, 65.28],
    [39.17, 69.13], [34.84, 73.08], [27.29, 73.24],
  ];

  final cBP = Path()..addPolygon(genOffsetList(cBlackPoints, dim), true);
  final cYP = Path()..addPolygon(genOffsetList(cYellowPoints, dim), true);
  final eLCP = Path()..addPolygon(genOffsetList(eLCPoints, dim), true);
  final eRCP = Path()..addPolygon(genOffsetList(eRCPoints, dim), true);
  final mCP = Path()..addPolygon(genOffsetList(mCPoints, dim), true);

  canvas.drawPath(cBP, blackPaint);
  canvas.drawPath(cYP, yellowPaint);
  canvas.drawPath(eLCP, blackPaint);
  canvas.drawPath(eRCP, blackPaint);
  canvas.drawPath(mCP, blackPaint);
}

void _drawD(
  Canvas canvas,
  DimensionConvert dim,
  Paint blackPaint,
  Paint bluePaint,
) {
  final List<List<double>> dPoints = [
    [52.03, 51.65], [35.80, 51.15], [35.29, 34.97], [53.47, 16.85], //
    [80.25, 16.85], [100.0, 36.53], [100.0, 63.23], [81.82, 81.36],
  ];

  final List<List<double>> eLDPoints = [
    [58.92, 44.50], [55.03, 40.85], [57.05, 35.41], [60.79, 35.70], //
    [64.28, 39.57], [63.91, 43.77],
  ];

  final List<List<double>> eRDPoints = [
    [68.45, 32.61], [66.79, 30.82], [68.46, 27.73], [71.51, 27.84], //
    [72.89, 28.81], [72.99, 32.30],
  ];

  final List<List<double>> mDPoints = [
    [76.76, 63.66], [73.56, 60.55], [73.10, 55.34], [77.17, 54.51], //
    [79.36, 52.13], [79.36, 52.13], [79.81, 45.16], [87.91, 44.22],
    [89.57, 56.60], [84.76, 57.34], [83.70, 63.45],
  ];

  final dP = Path()..addPolygon(genOffsetList(dPoints, dim), true);
  final eLDP = Path()..addPolygon(genOffsetList(eLDPoints, dim), true);
  final eRDP = Path()..addPolygon(genOffsetList(eRDPoints, dim), true);
  final mDP = Path()..addPolygon(genOffsetList(mDPoints, dim), true);

  canvas.drawPath(dP, blackPaint);
  canvas.drawPath(eLDP, bluePaint);
  canvas.drawPath(eRDP, bluePaint);
  canvas.drawPath(mDP, bluePaint);
}
