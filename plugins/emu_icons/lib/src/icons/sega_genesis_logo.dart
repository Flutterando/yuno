import 'package:emu_icons/src/classes.dart';
import 'package:flutter/widgets.dart';

class SegaGenesisLogo extends StatelessWidget {
  final double size;
  const SegaGenesisLogo({
    super.key,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: SegaGenesisLogoPainter(),
    );
  }
}

class SegaGenesisLogoPainter extends CustomPainter {
  final Color? color;

  SegaGenesisLogoPainter({
    super.repaint,
    this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    DimensionConvert dim = DimensionConvert(size: size);

    if (color != null) {
      paint.color = color!;
    } else {
      paint.color = const Color(0xff000000);
    }

    final List<List<double>> gPoints = [
      [06.97, 58.15],
      [06.97, 51.33],
      [10.20, 49.17],
      [20.79, 49.17],
      [17.66, 51.29],
      [10.87, 51.29],
      [10.87, 56.02],
      [15.72, 56.02],
      [15.72, 54.72],
      [11.79, 54.72],
      [14.92, 52.61],
      [19.61, 52.61],
      [19.61, 56.16],
      [16.65, 58.15],
    ];

    final List<List<double>> ePoints = [
      [20.66, 58.15],
      [20.66, 51.24],
      [24.06, 49.17],
      [33.32, 49.17],
      [30.14, 51.26],
      [24.56, 51.26],
      [24.56, 52.61],
      [31.43, 52.61],
      [28.30, 54.72],
      [24.56, 54.72],
      [24.56, 56.03],
      [33.32, 56.03],
      [30.14, 58.15],
    ];

    final List<List<double>> nPoints = [
      [34.23, 58.15],
      [34.23, 49.15],
      [38.15, 49.15],
      [43.02, 51.80],
      [43.02, 49.15],
      [46.94, 49.15],
      [46.94, 58.15],
      [43.02, 58.15],
      [43.02, 55.16],
      [38.15, 52.13],
      [38.15, 58.16],
    ];

    final List<List<double>> sPoints = [
      [60.43, 54.72],
      [60.43, 51.31],
      [63.65, 49.15],
      [73.23, 49.16],
      [70.10, 51.26],
      [64.34, 51.26],
      [64.34, 52.61],
      [73.04, 52.61],
      [73.04, 56.06],
      [69.94, 58.15],
      [60.37, 58.14],
      [63.51, 56.02],
      [69.15, 56.02],
      [69.15, 54.73],
    ];

    final List<List<double>> iPoints = [
      [74.26, 58.15],
      [74.26, 49.15],
      [78.18, 49.15],
      [78.18, 58.15],
    ];

    final gPath = Path()..addPolygon(genOffsetList(gPoints, dim), true);
    final e1Path = Path()..addPolygon(genOffsetList(ePoints, dim), true);
    final nPath = Path()..addPolygon(genOffsetList(nPoints, dim), true);
    final e2Path = Path()..addPolygon(genOffsetList(ePoints, dim), true);
    final s1Path = Path()..addPolygon(genOffsetList(sPoints, dim), true);
    final iPath = Path()..addPolygon(genOffsetList(iPoints, dim), true);
    final s2Path = Path()..addPolygon(genOffsetList(sPoints, dim), true);

    canvas.drawPath(gPath, paint);
    canvas.drawPath(e1Path, paint);
    canvas.drawPath(nPath, paint);
    canvas.save();
    canvas.translate(dim.w(27.25), dim.h(00.00));
    canvas.drawPath(e2Path, paint);
    canvas.restore();
    canvas.drawPath(s1Path, paint);
    canvas.drawPath(iPath, paint);
    canvas.save();
    canvas.translate(dim.w(19.25), dim.h(00.00));
    canvas.drawPath(s2Path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
