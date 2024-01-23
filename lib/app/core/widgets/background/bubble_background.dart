import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class BubbleBackground extends StatelessWidget {
  const BubbleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final color = ColorProvider.of(context).color;
    if (kDebugMode) {
      print("BubbleBackground: $color");
    }
    return Stack(
      key: Key(color.toString()),
      children: [
        Positioned.fill(
          child: FloatingBubbles.alwaysRepeating(
            noOfBubbles: 20,
            colorsOfBubbles: [color],
            sizeFactor: 0.16,
            opacity: 50,
            paintingStyle: PaintingStyle.stroke,
            strokeWidth: 8,
            shape: BubbleShape.circle,
            speed: BubbleSpeed.slow,
          ),
        ),
      ],
    );
  }
}
