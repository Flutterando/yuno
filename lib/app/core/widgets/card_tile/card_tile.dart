import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yuno/app/interactor/models/game.dart';

class CardTile extends StatelessWidget {
  final Animation<double> transitionAnimation;
  final int index;
  final int gamesLength;
  final VoidCallback? onTap;
  final bool selected;
  final Game game;

  const CardTile({
    super.key,
    required this.game,
    required this.transitionAnimation,
    required this.index,
    required this.gamesLength,
    this.onTap,
    this.selected = false,
  });

  Widget noImage() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.image_not_supported_outlined),
          const Gap(8),
          Text(
            game.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget withImage() {
    return Image.file(
      File(game.image),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    double start = index / gamesLength;
    double duration = 1 / gamesLength;

    final curved = CurvedAnimation(
      parent: transitionAnimation,
      curve: const Interval(0.5, 1.0),
    );

    final animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: curved,
      curve: Interval(start, start + duration, curve: Curves.easeOut),
    ));

    final scale = selected ? 1.0 : 0.97;
    final borderRadius = BorderRadius.circular(12);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, snapshot) {
        return Opacity(
          opacity: lerpDouble(1.0, 0.0, animation.value)!,
          child: Transform.translate(
            offset: Offset(0, animation.value * 100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()..scale(scale),
              transformAlignment: Alignment.center,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                child: InkWell(
                  borderRadius: borderRadius,
                  onTap: onTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(
                        color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                        width: 3,
                      ),
                      image: game.hasImage
                          ? DecorationImage(
                              image: FileImage(File(game.image)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: game.hasImage ? null : noImage(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
