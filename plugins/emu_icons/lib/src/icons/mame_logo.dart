import 'package:flutter/widgets.dart';

import '../classes.dart';

class MameLogo extends StatelessWidget {
  final Color? color;
  final double size;
  const MameLogo({
    super.key,
    this.size = 400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _MameLogoPainter(color: color),
    );
  }
}

class _MameLogoPainter extends CustomPainter {
  final Color? color;

  _MameLogoPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);
    final backPaint = Paint();
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = dim.h(00.50);

    if (color != null) {
      backPaint.color = color!;
      borderPaint.color = color!;
    } else {
      backPaint.shader = const LinearGradient(
        colors: [
          Color(0xff68CAFB),
          Color(0xff00274F),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(
        Rect.fromLTRB(
          dim.w(00.00),
          dim.h(36.13),
          dim.w(100.0),
          dim.h(63.87),
        ),
      );

      borderPaint.shader = LinearGradient(
        colors: [
          const Color(0xff00274F).withOpacity(0.75),
          const Color(0xff68CAFB).withOpacity(0.75),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(
        Rect.fromLTRB(
          dim.w(00.00),
          dim.h(36.13),
          dim.w(100.0),
          dim.h(63.87),
        ),
      );
    }

    final List<List<double>> bodyPoints = [
      [20.78, 36.13], [20.78, 45.23], [29.89, 36.13], [29.89, 50.57], //
      [44.63, 36.13], [44.63, 52.41], [60.98, 36.13], [60.98, 45.24], //
      [70.24, 36.13], [70.24, 50.95], [84.03, 36.13], [100.0, 36.13], //
      [95.09, 41.38], [87.12, 41.38], [84.87, 43.67], [88.88, 43.67], //
      [83.50, 49.30], [78.91, 49.30], [76.88, 51.55], [90.65, 51.55], //
      [85.54, 56.84], [63.84, 56.84], [65.00, 55.73], [65.00, 49.87], //
      [57.54, 57.40], [57.54, 48.28], [48.79, 56.84], [39.19, 56.84], //
      [39.19, 49.82], [25.29, 63.87], [16.81, 63.87], [24.80, 55.71], //
      [24.80, 49.87], [16.87, 57.40], [16.87, 48.28], [08.38, 56.84], //
      [00.00, 56.84],
    ];

    final path = Path()..addPolygon(genOffsetList(bodyPoints, dim), true);

    canvas.drawPath(path, backPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}
