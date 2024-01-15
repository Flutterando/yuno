import 'package:flutter/material.dart';
import 'package:newton_particles/newton_particles.dart';

import 'background.dart';

class ParticlesBackground extends StatelessWidget {
  const ParticlesBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final color = ColorProvider.of(context).color;

    return Newton(
      activeEffects: [
        RainEffect(
          particleConfiguration: ParticleConfiguration(
            shape: CircleShape(),
            size: const Size(5, 5),
            color: SingleParticleColor(color: color),
          ),
          effectConfiguration: const EffectConfiguration(
            minDuration: 6000,
            maxDuration: 10000,
          ),
        )
      ],
    );
  }
}
