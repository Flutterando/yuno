import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveBackground extends StatelessWidget {
  final Color color;
  const WaveBackground({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
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
