import 'package:flutter/material.dart';

import 'bubble_background.dart';
import 'particles_background.dart';
import 'waves_background.dart';

enum BackgroundType {
  waves,
  bubble,
  particles,
  none,
}

class Background extends StatefulWidget {
  final BackgroundType type;
  final Color color;
  const Background({
    super.key,
    required this.type,
    required this.color,
  });

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  var oldColor = Colors.transparent;
  var color = Colors.transparent;

  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    color = widget.color;
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 1), value: 0.5);
    _controller.addListener(() {
      setState(() {});
    });

    fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 0.0,
        ),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ),
        weight: 30,
      ),
    ]).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void didUpdateWidget(covariant Background oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color == widget.color) {
      return;
    }
    oldColor = oldWidget.color;
    color = widget.color;
    _controller.value = 0;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectColor = _controller.value > 0.40 ? color : oldColor;

    return ColorProvider(
      color: selectColor,
      child: Opacity(
        opacity: fadeAnimation.value,
        child: switch (widget.type) {
          BackgroundType.waves => const WaveBackground(),
          BackgroundType.bubble => const BubbleBackground(),
          BackgroundType.particles => const ParticlesBackground(),
          BackgroundType.none => const SizedBox(),
        },
      ),
    );
  }
}

class ColorProvider extends InheritedWidget {
  final Color color;
  const ColorProvider({super.key, required super.child, required this.color});

  static ColorProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ColorProvider oldWidget) {
    return oldWidget.color != color;
  }
}
