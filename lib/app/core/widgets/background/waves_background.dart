import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'background.dart';

class WaveBackground extends StatelessWidget {
  const WaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final color = ColorProvider.of(context).color;

    return Stack(
      children: [
        Positioned.fill(
          child: WaveWidget(
            config: CustomConfig(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.1),
                color.withOpacity(0.1),
              ],
              durations: [
                7000,
                6000,
                10000,
              ],
              heightPercentages: [
                0.10,
                0.40,
                0.60,
              ],
            ),
            size: const Size(double.infinity, double.infinity),
            waveAmplitude: 2,
          ),
        ),
      ],
    );
  }
}
