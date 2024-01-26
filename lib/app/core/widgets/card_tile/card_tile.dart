import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:yuno/app/interactor/atoms/game_atom.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

class CardTile extends StatelessWidget {
  final Animation<double> transitionAnimation;
  final int index;
  final int gamesLength;
  final VoidCallback? onTap;
  final bool selected;
  final Game game;
  final Color colorSelect;
  final void Function() onLongPressed;

  const CardTile({
    super.key,
    required this.game,
    required this.transitionAnimation,
    required this.index,
    required this.gamesLength,
    required this.colorSelect,
    this.onTap,
    this.selected = false,
    required this.onLongPressed,
  });

  Widget noImage() {
    final player = game.overradedPlayer;
    if (player != null) {
      return Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.memory(player.app.icon, fit: BoxFit.cover),
          ),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.memory(
                      player.app.icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
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
                  onLongPress: onLongPressed,
                  borderRadius: borderRadius,
                  onTap: onTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(
                        color: selected ? colorSelect : Colors.transparent,
                        width: 3,
                      ),
                      image: game.hasImage
                          ? DecorationImage(
                              image: FileImage(File(game.image)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: Stack(
                      children: [
                        if (!game.hasImage) Center(child: noImage()),
                        if (game.isFavorite)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: SvgPicture.asset(
                                  defaultCategoryFavorite.image,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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
