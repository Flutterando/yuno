import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  final String text;
  final String subtext;
  final int index;
  final int gamesLength;
  final Animation<double> transitionAnimation;
  final bool selected;
  final ColorScheme colorScheme;
  final void Function()? onTap;
  final void Function()? onLongPressed;

  const AnimatedTile({
    super.key,
    required this.text,
    required this.subtext,
    required this.colorScheme,
    required this.transitionAnimation,
    required this.index,
    required this.gamesLength,
    this.selected = false,
    this.onTap,
    this.onLongPressed,
  });

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _tileSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _controller.value = widget.selected ? 1 : 0;

    Listenable.merge([
      _controller,
      widget.transitionAnimation,
    ]).addListener(_listener);

    final start = widget.index / widget.gamesLength;
    final duration = 1 / widget.gamesLength;

    final curved = CurvedAnimation(
      parent: widget.transitionAnimation,
      curve: const Interval(0.5, 1.0),
    );

    _tileSlideAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: curved,
      curve: Interval(start, start + duration, curve: Curves.easeOut),
    ));
  }

  void _listener() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant AnimatedTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected == widget.selected) {
      return;
    }

    if (widget.selected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    widget.transitionAnimation.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTranslate = Tween<Offset>(
      begin: const Offset(0, 10.0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    final subtextOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    return Transform.translate(
      offset: Offset(_tileSlideAnimation.value * -200, 0),
      child: Opacity(
        opacity: lerpDouble(1.0, 0.0, _tileSlideAnimation.value)!,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 4.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: widget.selected
                ? widget.colorScheme.surface
                : theme.colorScheme.surface,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: widget.onTap,
              onLongPress: widget.onLongPressed,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: textTranslate.value,
                            child: Text(
                              widget.text,
                              maxLines: 1,
                              style: theme.textTheme.titleMedium?.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: widget.selected
                                    ? widget.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: subtextOpacity.value,
                            child: Text(
                              widget.subtext,
                              maxLines: 1,
                              style: theme.textTheme.bodySmall?.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: widget.selected
                                    ? widget.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: widget.selected
                          ? widget.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
