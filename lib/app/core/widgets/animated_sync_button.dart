import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedSyncButton extends StatefulWidget {
  final bool isSyncing;
  final VoidCallback? onPressed;
  const AnimatedSyncButton({
    required this.isSyncing,
    required this.onPressed,
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
      animate();
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedSyncButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSyncing != widget.isSyncing) {
      animate();
    }
  }

  void animate(){
    if (widget.isSyncing) {
      controller.repeat();
    } else {
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Transform.rotate(
        angle: controller.value * (pi * 2),
        alignment: Alignment.center,
        child: const Icon(Icons.sync),
      ),
    );
  }
}
