import 'package:flutter/widgets.dart';

import '../classes.dart';

class NeoGeoLogo extends StatelessWidget {
  final double size;
  const NeoGeoLogo({
    super.key,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: NeoGeoLogoPainter(),
    );
  }
}

class NeoGeoLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    Color yellow = const Color(0xffFFC011);
    final yellowPaint = Paint()..color = yellow;

    Color blue = const Color(0xff00A2E7);
    final bluePaint = Paint()..color = blue;

    _drawN(canvas, dim, yellowPaint);
    _drawYE(canvas, dim, yellowPaint);
    _drawYO(canvas, dim, yellowPaint);
    _drawG(canvas, dim, bluePaint);
    _drawBE(canvas, dim, bluePaint);
    _drawBO(canvas, dim, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawN(Canvas canvas, DimensionConvert dim, Paint yellowPaint) {
  final List<List<double>> nPoints = [
    [09.01, 53.78], [09.73, 25.38], [13.04, 22.26], [26.13, 31.97], //
    [28.62, 11.88], [29.50, 17.32], [31.15, 14.89], [31.62, 17.29],
    [33.42, 14.42], [34.42, 49.17], [16.08, 35.07], [09.01, 53.78],
  ];

  final n = Path()..addPolygon(genOffsetList(nPoints, dim), true);
  canvas.drawPath(n, yellowPaint);
}

void _drawYE(Canvas canvas, DimensionConvert dim, Paint yellowPaint) {
  final List<List<double>> eYellowPoints = [
    [38.21, 52.71], [36.87, 12.37], [59.76, 05.38], [55.17, 08.31], //
    [58.19, 08.37], [53.55, 11.73], [58.73, 11.55], [43.20, 21.66],
    [60.38, 20.68], [43.28, 33.38], [43.71, 37.49], [56.42, 35.08],
    [52.40, 37.79], [55.94, 37.21], [53.47, 38.86], [56.92, 38.53],
    [38.21, 52.71],
  ];
  final eY = Path()..addPolygon(genOffsetList(eYellowPoints, dim), true);
  canvas.drawPath(eY, yellowPaint);
}

void _drawYO(Canvas canvas, DimensionConvert dim, Paint yellowPaint) {
  final List<List<double>> oYellowPoints = [
    [81.49, 55.26], [73.23, 52.32], [63.31, 39.24], [58.10, 27.33], //
    [65.57, 15.63], [79.05, 19.00], [88.88, 32.36], [90.99, 42.96],
    [81.49, 55.26],
  ];

  final eLOYellowPoints = [
    [67.61, 33.46], [66.20, 32.75], [66.28, 31.43], [67.14, 30.73], //
    [68.78, 31.11], [69.09, 32.27], [67.61, 33.46],
  ];

  final eROYellowPoints = [
    [76.29, 29.86], [74.18, 29.82], [73.01, 27.64], [74.29, 25.64], //
    [75.84, 25.64], [77.37, 27.75], [76.29, 29.86],
  ];

  final mOYellowPoints = [
    [72.81, 44.36], [75.01, 45.01], [79.06, 44.93], [80.79, 43.74], //
    [82.57, 41.46], [84.17, 36.34], [84.68, 40.10], [84.18, 43.13],
    [82.17, 45.38], [79.88, 46.83], [75.84, 46.66], [72.81, 44.36],
  ];
  final oY = Path()..addPolygon(genOffsetList(oYellowPoints, dim), true);
  final eLOY = Path()..addPolygon(genOffsetList(eLOYellowPoints, dim), true);
  final eROY = Path()..addPolygon(genOffsetList(eROYellowPoints, dim), true);
  final mOY = Path()..addPolygon(genOffsetList(mOYellowPoints, dim), true);
  final auxOY1 = Path.combine(PathOperation.difference, oY, eLOY);
  final auxOY2 = Path.combine(PathOperation.difference, auxOY1, eROY);
  final auxOY3 = Path.combine(PathOperation.difference, auxOY2, mOY);
  canvas.drawPath(auxOY3, yellowPaint);
}

void _drawG(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final pRecArc01 = Rect.fromLTRB(
    dim.w(11.37), dim.h(48.48), dim.w(34.88), dim.h(72.00), //
  );
  final pRecArc02 = Rect.fromLTRB(
    dim.w(16.41), dim.h(56.68), dim.w(29.55), dim.h(69.81), //
  );
  final pRecArc03 = Rect.fromLTRB(
    dim.w(16.04), dim.h(49.87), dim.w(57.32), dim.h(80.34), //
  );
  final pRecArc04 = Rect.fromLTRB(
    dim.w(16.00), dim.h(46.24), dim.w(58.79), dim.h(82.51), //
  );

  final Path gPath = Path()
    ..moveTo(dim.w(36.85), dim.h(94.62))
    ..quadraticBezierTo(
      dim.w(10.00), dim.h(84.00), dim.w(10.60), dim.h(66.12), //
    )
    ..quadraticBezierTo(
      dim.w(11.00), dim.h(59.00), dim.w(11.87), dim.h(56.84), //
    )
    ..arcTo(
      pRecArc01,
      degreesToRadian(196.79),
      degreesToRadian(115.20),
      false,
    )
    ..quadraticBezierTo(
      dim.w(27.00), dim.h(48.40), dim.w(30.98), dim.h(51.48), //
    )
    ..lineTo(dim.w(36.57), dim.h(63.49))
    ..lineTo(dim.w(26.49), dim.h(57.69))
    ..arcTo(
      pRecArc02,
      degreesToRadian(297.46),
      -degreesToRadian(093.75),
      false,
    )
    ..arcTo(
      pRecArc03,
      degreesToRadian(197.20),
      -degreesToRadian(022.95),
      false,
    )
    ..arcTo(
      pRecArc04,
      degreesToRadian(172.78),
      -degreesToRadian(059.17),
      false,
    )
    ..lineTo(dim.w(26.72), dim.h(73.16))
    ..lineTo(dim.w(20.92), dim.h(72.97))
    ..lineTo(dim.w(23.76), dim.h(70.74))
    ..lineTo(dim.w(20.36), dim.h(70.65))
    ..lineTo(dim.w(24.06), dim.h(67.77))
    ..lineTo(dim.w(21.27), dim.h(67.69))
    ..lineTo(dim.w(31.45), dim.h(64.32));

  canvas.drawPath(gPath, bluePaint);
}

void _drawBE(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final List<List<double>> eBluePoints = [
    [49.58, 92.61], [33.71, 71.87], [52.42, 45.02], [64.27, 54.61], //
    [62.22, 54.22], [65.44, 58.54], [61.59, 57.34], [63.93, 59.99],
    [50.72, 55.77], [58.88, 70.28], [42.86, 69.82], [51.72, 87.37],
    [48.59, 86.56], [50.09, 90.36], [47.58, 88.43], [49.58, 92.61],
  ];

  final eB = Path()..addPolygon(genOffsetList(eBluePoints, dim), true);
  canvas.drawPath(eB, bluePaint);
}

void _drawBO(Canvas canvas, DimensionConvert dim, Paint bluePaint) {
  final List<List<double>> oBluePoints = [
    [62.63, 91.26], [57.41, 86.73], [57.37, 74.50], [70.15, 57.92], //
    [87.76, 57.48], [87.14, 74.80], [72.19, 89.00], [62.63, 91.26],
  ];

  final List<List<double>> eLOBluePoints = [
    [72.40, 68.41], [70.40, 66.02], [71.82, 63.08], [75.20, 62.71], //
    [76.34, 65.00], [75.32, 67.72], [72.40, 68.41],
  ];

  final List<List<double>> eROBluePoints = [
    [80.93, 72.82], [79.08, 71.73], [78.80, 69.87], [80.00, 69.15], //
    [82.09, 69.62], [82.16, 71.08], [80.93, 72.82],
  ];

  final List<List<double>> mOBluePoints = [
    [63.21, 83.22], [61.98, 79.35], [62.97, 77.04], [66.26, 75.65], //
    [68.25, 78.58], [69.91, 79.03], [72.92, 77.96], [75.17, 82.64],
    [70.58, 84.43], [67.61, 84.71], [66.54, 83.22], [63.21, 83.22],
  ];

  final oB = Path()..addPolygon(genOffsetList(oBluePoints, dim), true);
  final eLOB = Path()..addPolygon(genOffsetList(eLOBluePoints, dim), true);
  final eROB = Path()..addPolygon(genOffsetList(eROBluePoints, dim), true);
  final mOB = Path()..addPolygon(genOffsetList(mOBluePoints, dim), true);
  final auxOB1 = Path.combine(PathOperation.difference, oB, eLOB);
  final auxOB2 = Path.combine(PathOperation.difference, auxOB1, eROB);
  final auxOB3 = Path.combine(PathOperation.difference, auxOB2, mOB);

  canvas.drawPath(auxOB3, bluePaint);
}
