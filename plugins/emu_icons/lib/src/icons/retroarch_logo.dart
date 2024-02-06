import 'package:flutter/widgets.dart';

import '../classes.dart';

class RetroArchLogo extends StatelessWidget {
  final double size;
  const RetroArchLogo({
    super.key,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: RetroArchLogoPainter(),
    );
  }
}

class RetroArchLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    DimensionConvert dim = DimensionConvert(size: size);

    final List<List<double>> bodyPoints = [
      [50.00, 63.16], [38.27, 63.16], [28.25, 75.54], [19.29, 75.54], //
      [29.61, 63.27], [14.22, 63.16], [16.30, 55.05], [00.00, 55.05], //
      [05.48, 32.63], [11.53, 32.63], [08.66, 45.00], [19.22, 45.00], //
      [19.22, 45.00], [22.07, 32.63], [36.72, 32.63], [30.34, 24.57], //
      [36.41, 24.57], [43.29, 32.63], [50.00, 32.63], [50.00, 32.60], //
      [56.70, 32.60], [63.60, 24.60], [69.70, 24.60], [63.30, 32.60], //
      [77.90, 32.60], [80.80, 45.00], [80.80, 45.00], [91.30, 45.00], //
      [88.50, 32.60], [94.50, 32.60], [100.0, 55.00], [83.70, 55.00], //
      [85.80, 63.20], [70.40, 63.30], [80.70, 75.50], [71.80, 75.50], //
      [61.70, 63.20], [50.00, 63.20],
    ];

    final List<List<double>> lEyePoints = [
      [27.87, 48.95], [27.87, 38.68], [38.68, 38.68], [38.68, 48.95], //
    ];

    final List<List<double>> rEyePoints = [
      [72.13, 48.95], [72.13, 38.68], [61.32, 38.68], [61.32, 48.95], //
    ];

    final bodyPath = Path()..addPolygon(genOffsetList(bodyPoints, dim), true);

    final lEyePath = Path()..addPolygon(genOffsetList(lEyePoints, dim), true);

    final rEyePath = Path()..addPolygon(genOffsetList(rEyePoints, dim), true);

    final auxPath = Path.combine(PathOperation.difference, bodyPath, lEyePath);
    final path = Path.combine(PathOperation.difference, auxPath, rEyePath);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
