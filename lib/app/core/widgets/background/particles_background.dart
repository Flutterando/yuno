import 'package:flutter/material.dart';
import 'package:newton_particles/newton_particles.dart';

class ParticlesBackground extends StatelessWidget {
  final Color color;
  const ParticlesBackground({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
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
