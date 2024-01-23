import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';

class AnimatedSearch extends StatefulWidget {
  final void Function(String value) onChanged;

  const AnimatedSearch({super.key, required this.onChanged});

  @override
  State<AnimatedSearch> createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> iconSizeAnimation;
  late final Animation<double> sizeFieldAnimation;
  late final Animation<double> iconRotationAnimation;

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _controller.addListener(() {
      setState(() {});
    });

    const iconMaxSize = 30.0;
    const iconMinSize = 1.0;

    iconSizeAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: iconMaxSize, end: iconMinSize),
          weight: 20,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: iconMinSize, end: iconMinSize),
          weight: 60,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: iconMinSize, end: iconMaxSize),
          weight: 20,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7),
        reverseCurve: const Interval(0.0, 1.0),
      ),
    );

    sizeFieldAnimation = Tween<double>(begin: 0, end: 250).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    iconRotationAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
        reverseCurve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Transform.rotate(
            angle: iconRotationAnimation.value,
            child: Icon(
              _controller.value >= 0.5 ? Icons.close : Icons.search,
              size: iconSizeAnimation.value,
            ),
          ),
          onPressed: () {
            if (_controller.value == 0) {
              _controller.forward();
              _focusNode.requestFocus();
            } else {
              widget.onChanged('');
              _controller.reverse();
              _focusNode.unfocus();
            }
          },
        ),
        if (_controller.value != 0)
          SizedBox(
            width: sizeFieldAnimation.value,
            child: TextField(
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: 'search_a_game'.i18n(),
                border: InputBorder.none,
              ),
            ),
          ),
        if (_focusNode.hasFocus)
          IconButton(
            onPressed: () {
              _focusNode.unfocus();
            },
            icon: const Icon(Icons.keyboard_hide),
          ),
        const Gap(5),
      ],
    );
  }
}
