import 'package:flutter/material.dart';

import 'bubble_background.dart';
import 'waves_background.dart';

enum BackgroundType {
  waves,
  bubble,
  none,
}

class Background extends StatelessWidget {
  final BackgroundType type;
  final Color color;
  const Background({super.key, required this.type, required this.color});

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      BackgroundType.waves => WaveBackground(color: color),
      BackgroundType.bubble => BubbleBackground(color: color, key: ValueKey(color)),
      BackgroundType.none => const SizedBox(),
    };
  }
}
