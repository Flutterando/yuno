import 'package:flutter/widgets.dart';

import '../classes.dart';

class AndroidLogo extends StatelessWidget {
  final double size;
  const AndroidLogo({
    super.key,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _AndroidLogoPainter(),
    );
  }
}

class _AndroidLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);
    Color green = const Color(0xff3DDB85);
    final greenPaint = Paint()..color = green;

    _drawAntennas(canvas, dim, greenPaint);
    _drawHead(canvas, dim, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawAntennas(Canvas canvas, DimensionConvert dim, Paint greenPaint) {
  final rectArcAntenna = Rect.fromLTRB(
    dim.w(-01.77), dim.h(00.00), dim.w(01.77), dim.h(03.54), //
  );

  final antennaPath = Path()
    ..moveTo(dim.w(-01.77), dim.h(18.94))
    ..lineTo(dim.w(-01.77), dim.h(17.18))
    ..arcTo(
      rectArcAntenna,
      degreesToRadian(180),
      degreesToRadian(180),
      false,
    )
    ..lineTo(dim.w(01.77), dim.h(18.94));

  //Coordenadas polares para cartesianas
  const angleLAntenna = -30.0;
  const angleRAntenna = 30.0;
  final originLAntenna = Offset(dim.w(17.75), dim.h(22.13));
  final originRAntenna = Offset(dim.w(82.25), dim.h(22.13));

  final posLAntenna = polarToCartesianPoint(
    origin: originLAntenna,
    originDistance: 0,
    radianAngle: degreesToRadian(angleLAntenna),
  );

  final posRAntenna = polarToCartesianPoint(
    origin: originRAntenna,
    originDistance: 0,
    radianAngle: degreesToRadian(angleRAntenna),
  );

  canvas.save();
  canvas.translate(posLAntenna.dx, posLAntenna.dy);
  canvas.rotate(degreesToRadian(angleLAntenna));
  canvas.drawPath(antennaPath, greenPaint);
  canvas.restore();
  canvas.save();
  canvas.translate(posRAntenna.dx, posRAntenna.dy);
  canvas.rotate(degreesToRadian(angleRAntenna));
  canvas.drawPath(antennaPath, greenPaint);
  canvas.restore();
}

void _drawHead(Canvas canvas, DimensionConvert dim, Paint greenPaint) {
  final rectArcHead = Rect.fromLTRB(
    dim.w(000.00), dim.h(032.70), dim.w(100.00), dim.h(123.27), //
  );

  final headPath = Path()
    ..moveTo(dim.w(-00.00), dim.h(78.14))
    ..addArc(
      rectArcHead,
      degreesToRadian(180),
      degreesToRadian(180),
    );

  final leftEyeRect = Rect.fromLTRB(
    dim.w(22.84), dim.h(55.65), dim.w(31.17), dim.h(63.98), //
  );

  final rightEyeRect = Rect.fromLTRB(
    dim.w(68.86), dim.h(55.65), dim.w(77.20), dim.h(64.00), //
  );

  final lEyePath = Path()..addOval(leftEyeRect);
  final rEyePath = Path()..addOval(rightEyeRect);

  final cuttedLEye = Path.combine(
    PathOperation.difference, headPath, lEyePath, //
  );

  final cuttedEyes = Path.combine(
    PathOperation.difference, cuttedLEye, rEyePath, //
  );

  canvas.drawPath(cuttedEyes, greenPaint);
}
