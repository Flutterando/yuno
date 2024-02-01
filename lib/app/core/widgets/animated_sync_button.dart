import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedSyncButton extends StatefulWidget {
  final bool isSyncing;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const AnimatedSyncButton({
    required this.isSyncing,
    this.onPressed,
    this.onLongPressed,
    super.key,
  });

  @override
  State<AnimatedSyncButton> createState() => _AnimatedSyncButtonState();
}

class _AnimatedSyncButtonState extends State<AnimatedSyncButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    controller.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animate(true);
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedSyncButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSyncing != widget.isSyncing) {
      animate();
    }
  }

  void animate([bool first = false]) {
    if (widget.isSyncing) {
      controller.repeat();
    } else {
      if (first) {
        controller.reset();
      } else {
        controller.forward();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onLongPress: widget.onLongPressed,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Transform.rotate(
          angle: controller.value * (pi * 2),
          alignment: Alignment.center,
          child: const Icon(Icons.sync),
        ),
      ),
    );
  }
}
