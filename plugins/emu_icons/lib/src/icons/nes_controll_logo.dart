import 'package:flutter/widgets.dart';

import '../classes.dart';

class NesControllLogo extends StatelessWidget {
  final double size;
  const NesControllLogo({
    super.key,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NesLogoPainter(),
    );
  }
}

class _NesLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    DimensionConvert dim = DimensionConvert(size: size);

    //Colors
    Color coverStick = const Color(0xff333333);
    final coverStickPaint = Paint()..color = coverStick;
    Color digitalController = const Color(0xff1A1A1A);
    final digitalControllerPaint = Paint()..color = digitalController;
    final backgroundContourPaint = Paint()
      ..color = digitalController
      ..style = PaintingStyle.stroke
      ..strokeWidth = dim.h(0.3);
    Color background = const Color(0xffE6E6E6);
    final backgroundPaint = Paint()..color = background;
    Color digitalContour = const Color(0xffCCCCCC);
    final digitalContourPaint = Paint()..color = digitalContour;
    Color gray1 = const Color(0xffB3B3B3);
    final gray1Paint = Paint()..color = gray1;
    Color gray2 = const Color(0xff999999);
    final gray2Paint = Paint()..color = gray2;
    Color redButtons = const Color(0xffCC0000);
    final redButtonsPaint = Paint()..color = redButtons;

    _drawBackground(canvas, dim, backgroundPaint, backgroundContourPaint);
    _drawStick(canvas, dim, coverStickPaint);
    _drawDigitalController(
      canvas,
      dim,
      digitalContourPaint,
      digitalControllerPaint,
    );
    _drawLines(
      canvas,
      dim,
      digitalContourPaint,
      backgroundPaint,
      gray1Paint,
      gray2Paint,
    );
    _drawSelectStart(canvas, dim, digitalControllerPaint);
    _drawBackgroundButton(canvas, dim, backgroundPaint);
    _drawABButtons(canvas, dim, redButtonsPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawBackground(
  Canvas canvas,
  DimensionConvert dim,
  Paint backgroundPaint,
  Paint backgroundContourPaint,
) {
  final rRectBack = RRect.fromLTRBR(
    dim.w(00.00), dim.h(28.32), dim.w(100.0), dim.h(71.68), //
    Radius.circular(dim.h(02.00)),
  );
  final backPath = Path()..addRRect(rRectBack);

  canvas.drawPath(backPath, backgroundPaint);
  canvas.drawPath(backPath, backgroundContourPaint);
}

void _drawStick(Canvas canvas, DimensionConvert dim, Paint coverStickPaint) {
  final rRectStick = RRect.fromLTRBR(
    dim.w(03.23), dim.h(35.37), dim.w(96.77), dim.h(68.34), //
    Radius.circular(dim.h(01.00)),
  );

  final rRectStickPath = Path()..addRRect(rRectStick);

  canvas.drawPath(rRectStickPath, coverStickPaint);
}

void _drawDigitalController(
  Canvas canvas,
  DimensionConvert dim,
  Paint digitalContourPaint,
  Paint digitalControllerPaint,
) {
  final rRectDigitalControllerBorderH = RRect.fromLTRBR(
    dim.w(07.94), dim.h(50.00), dim.w(25.96), dim.h(56.27), //
    Radius.circular(dim.h(01.00)),
  );

  final rRectDigitalControllerBorderV = RRect.fromLTRBR(
    dim.w(13.82), dim.h(44.12), dim.w(20.09), dim.h(62.14), //
    Radius.circular(dim.h(01.00)),
  );

  final rRectDigitalControllerH = RRect.fromLTRBR(
    dim.w(08.66), dim.h(50.71), dim.w(25.25), dim.h(55.55), //
    Radius.circular(dim.h(00.50)),
  );

  final rRectDigitalControllerV = RRect.fromLTRBR(
    dim.w(14.53), dim.h(44.84), dim.w(19.37), dim.h(61.43), //
    Radius.circular(dim.h(00.50)),
  );

  final rRectDigitalControllerBorderHPath = Path()
    ..addRRect(rRectDigitalControllerBorderH);
  final rRectDigitalControllerBorderVPath = Path()
    ..addRRect(rRectDigitalControllerBorderV);
  final rRectDigitalControllerHPath = Path()..addRRect(rRectDigitalControllerH);
  final rRectDigitalControllerVPath = Path()..addRRect(rRectDigitalControllerV);

  canvas.drawPath(rRectDigitalControllerBorderHPath, digitalContourPaint);
  canvas.drawPath(rRectDigitalControllerBorderVPath, digitalContourPaint);
  canvas.drawPath(rRectDigitalControllerHPath, digitalControllerPaint);
  canvas.drawPath(rRectDigitalControllerVPath, digitalControllerPaint);
}

void _drawLines(
  Canvas canvas,
  DimensionConvert dim,
  Paint digitalContourPaint,
  Paint backgroundPaint,
  Paint gray1Paint,
  Paint gray2Paint,
) {
  final line0 = RRect.fromLTRBAndCorners(
    dim.w(31.91), dim.h(66.04), dim.w(60.09), dim.h(68.34), //
    topLeft: Radius.circular(dim.h(01.00)),
    topRight: Radius.circular(dim.h(01.00)),
  );

  final startSelectStick = RRect.fromLTRBR(
    dim.w(31.91), dim.h(53.91), dim.w(60.09), dim.h(64.31), //
    Radius.circular(dim.h(01.00)),
  );

  final line1 = RRect.fromLTRBR(
    dim.w(31.91), dim.h(47.58), dim.w(60.09), dim.h(52.18), //
    Radius.circular(dim.h(00.50)),
  );

  final line2 = RRect.fromLTRBR(
    dim.w(31.91), dim.h(41.25), dim.w(60.09), dim.h(45.85), //
    Radius.circular(dim.h(00.50)),
  );

  final line3 = RRect.fromLTRBAndCorners(
    dim.w(31.91), dim.h(35.37), dim.w(60.09), dim.h(39.52), //
    topLeft: Radius.circular(dim.h(00.00)),
    topRight: Radius.circular(dim.h(00.00)),
    bottomLeft: Radius.circular(dim.h(01.00)),
    bottomRight: Radius.circular(dim.h(01.00)),
  );

  final line0Path = Path()..addRRect(line0);
  final startSelectStickPath = Path()..addRRect(startSelectStick);
  final line1Path = Path()..addRRect(line1);
  final line2Path = Path()..addRRect(line2);
  final line3Path = Path()..addRRect(line3);

  canvas.drawPath(line0Path, digitalContourPaint);
  canvas.drawPath(startSelectStickPath, backgroundPaint);
  canvas.drawPath(line1Path, gray1Paint);
  canvas.drawPath(line2Path, gray2Paint);
  canvas.drawPath(line3Path, gray2Paint);
}

void _drawSelectStart(
  Canvas canvas,
  DimensionConvert dim,
  Paint digitalControllerPaint,
) {
  final select = RRect.fromLTRBR(
    dim.w(35.25), dim.h(57.82), dim.w(43.18), dim.h(60.39), //
    Radius.circular(dim.h(01.28)),
  );

  final start = RRect.fromLTRBR(
    dim.w(48.78), dim.h(57.82), dim.w(56.78), dim.h(60.39), //
    Radius.circular(dim.h(01.28)),
  );

  final selectPath = Path()..addRRect(select);
  final startPath = Path()..addRRect(start);

  canvas.drawPath(selectPath, digitalControllerPaint);
  canvas.drawPath(startPath, digitalControllerPaint);
}

void _drawBackgroundButton(
  Canvas canvas,
  DimensionConvert dim,
  Paint backgroundPaint,
) {
  final bButtonBackground = RRect.fromLTRBR(
    dim.w(65.23), dim.h(53.47), dim.w(76.66), dim.h(64.89), //
    Radius.circular(dim.h(01.00)),
  );

  final aButtonBackground = RRect.fromLTRBR(
    dim.w(78.65), dim.h(53.47), dim.w(90.07), dim.h(64.89), //
    Radius.circular(dim.h(01.00)),
  );

  final bButtonBackgroundPath = Path()..addRRect(bButtonBackground);
  final aButtonBackgroundPath = Path()..addRRect(aButtonBackground);

  canvas.drawPath(bButtonBackgroundPath, backgroundPaint);
  canvas.drawPath(aButtonBackgroundPath, backgroundPaint);
}

void _drawABButtons(
  Canvas canvas,
  DimensionConvert dim,
  Paint redButtonsPaint,
) {
  final bButtonRect = Rect.fromLTRB(
    dim.w(66.66), dim.h(54.89), dim.w(75.23), dim.h(63.46), //
  );

  final aButtonRect = Rect.fromLTRB(
    dim.w(80.07), dim.h(54.89), dim.w(88.64), dim.h(63.46), //
  );

  final bButtonPath = Path()..addOval(bButtonRect);
  final aButtonPath = Path()..addOval(aButtonRect);

  canvas.drawPath(bButtonPath, redButtonsPaint);
  canvas.drawPath(aButtonPath, redButtonsPaint);
}
