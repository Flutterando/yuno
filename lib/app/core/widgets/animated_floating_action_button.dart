import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnimatedFloatingActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Animation<double> animation;

  const AnimatedFloatingActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.animation,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final translateAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ).drive(Tween<double>(
      begin: 100,
      end: 0,
    ));

    final rotationAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.elasticOut,
    ).drive(Tween<double>(
      begin: pi * 2,
      end: 0,
    ));

    final scheme = Theme.of(context).colorScheme;
    return ListenableBuilder(
      listenable: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            translateAnimation.value,
          ),
          child: Material(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: rotationAnimation.value,
                      child: Icon(icon),
                    ),
                    const Gap(8),
                    Text(label),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
