import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnimatedSearch extends StatefulWidget {
  final void Function(String value) onChanged;

  const AnimatedSearch({super.key, required this.onChanged});

  @override
  State<AnimatedSearch> createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeAnimation = Tween<double>(begin: 0, end: 250).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Transform.rotate(
            angle: _controller.value * pi,
            child: Icon(_controller.value != 0 ? Icons.close : Icons.search),
          ),
          onPressed: () {
            if (_controller.value == 0) {
              _controller.forward();
            } else {
              widget.onChanged('');
              _controller.reverse();
            }
          },
        ),
        if (_controller.value != 0)
          SizedBox(
            width: sizeAnimation.value,
            child: TextField(
              autofocus: true,
              onChanged: widget.onChanged,
              decoration: const InputDecoration(
                hintText: 'Search a Game',
                border: InputBorder.none,
              ),
            ),
          ),
        const Gap(5),
      ],
    );
  }
}
