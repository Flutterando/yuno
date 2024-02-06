import 'package:flutter/widgets.dart';

import '../classes.dart';

class GameCubeLogo extends StatelessWidget {
  final double size;
  const GameCubeLogo({
    super.key,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GameCubeLogoPainter(),
    );
  }
}

class _GameCubeLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    DimensionConvert dim = DimensionConvert(size: size);

    final List<List<double>> lPathPoints = [
      [48.11, 100.0], [06.00, 76.00], [06.00, 27.50], [19.83, 35.29], //
      [19.83, 67.79], [48.13, 84.06], [48.11, 100.0],
    ];

    final List<List<double>> upPathPoints = [
      [07.95, 23.97], [50.00, 00.00], [87.63, 21.50], [73.63, 29.61], //
      [50.00, 16.00], [21.74, 32.11], [07.95, 23.97],
    ];

    final List<List<double>> rPathPoints = [
      [51.88, 100.0], [51.88, 84.05], [80.17, 67.78], [80.17, 51.33], //
      [71.70, 56.28], [71.70, 63.00], [51.90, 74.35], [51.90, 51.87],
      [94.00, 27.50], [94.00, 75.68], [51.88, 100.0],
    ];

    final List<List<double>> lInnerPathPoints = [
      [48.00, 74.35], [28.30, 63.00], [28.30, 40.64], [48.00, 51.87], //
    ];

    final List<List<double>> topInnerPathPoints = [
      [30.25, 36.90], [50.00, 25.65], [69.75, 36.90], [50.00, 48.04], //
    ];

    final lPath = Path()..addPolygon(genOffsetList(lPathPoints, dim), true);
    final upPath = Path()..addPolygon(genOffsetList(upPathPoints, dim), true);
    final rPath = Path()..addPolygon(genOffsetList(rPathPoints, dim), true);
    final lInnerPath = Path()
      ..addPolygon(genOffsetList(lInnerPathPoints, dim), true);
    final topInnerPath = Path()
      ..addPolygon(genOffsetList(topInnerPathPoints, dim), true);

    canvas.drawPath(lPath, paint);
    canvas.drawPath(upPath, paint);
    canvas.drawPath(rPath, paint);
    canvas.drawPath(lInnerPath, paint);
    canvas.drawPath(topInnerPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
