import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';

class BubbleBackground extends StatelessWidget {
  final Color color;
  const BubbleBackground({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FloatingBubbles.alwaysRepeating(
            noOfBubbles: 10,
            colorsOfBubbles: [color],
            sizeFactor: 0.16,
            opacity: 30,
            paintingStyle: PaintingStyle.stroke,
            strokeWidth: 8,
            shape: BubbleShape.circle, // circle is the default. No need to explicitly mention if its a circle.
            speed: BubbleSpeed.slow, // normal is the default
          ),
        ),
      ],
    );
  }
}
