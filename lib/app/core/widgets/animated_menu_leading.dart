import 'package:flutter/material.dart';

class AnimatedMenuLeading extends ImplicitlyAnimatedWidget {
  final bool isCloseMenu;
  final AnimatedIconData icon;

  const AnimatedMenuLeading(
      {super.key, required this.icon, this.isCloseMenu = false})
      : super(duration: const Duration(milliseconds: 300));

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedMenuLeadingState();
  }
}

class _AnimatedMenuLeadingState
    extends AnimatedWidgetBaseState<AnimatedMenuLeading> {
  Tween<double>? _isCloseMenu;
  late Animation<double> _openCloseMenuAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _isCloseMenu = visitor(_isCloseMenu, widget.isCloseMenu ? 1.0 : 0.0,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _openCloseMenuAnimation = animation.drive(_isCloseMenu!);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: AnimatedIcons.menu_close,
      progress: _openCloseMenuAnimation,
    );
  }
}
