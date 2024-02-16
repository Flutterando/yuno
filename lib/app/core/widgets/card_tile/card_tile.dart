import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

import '../../assets/svgs.dart';

class CardTile extends InheritedWidget {
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
  }) : super(child: const _CardTile());

  static CardTile _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CardTile>()!;
  }

  @override
  bool updateShouldNotify(CardTile oldWidget) {
    var update = oldWidget.game.path != game.path ||
        oldWidget.transitionAnimation != transitionAnimation ||
        oldWidget.index != index ||
        oldWidget.gamesLength != gamesLength ||
        oldWidget.selected != selected;

    if (selected) {
      update = update || oldWidget.colorSelect != colorSelect;
    }

    return update;
  }
}

class _CardTile extends StatelessWidget {
  const _CardTile();

  Widget noImage(Game game) {
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

  @override
  Widget build(BuildContext context) {
    final tile = CardTile._of(context);
    double start = tile.index / tile.gamesLength;
    double duration = 1 / tile.gamesLength;

    final curved = CurvedAnimation(
      parent: tile.transitionAnimation,
      curve: const Interval(0.5, 1.0),
    );

    final animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: curved,
      curve: Interval(start, start + duration, curve: Curves.easeOut),
    ));

    final scale = tile.selected ? 1.0 : 0.97;
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
                  onLongPress: tile.onLongPressed,
                  borderRadius: borderRadius,
                  onTap: tile.onTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(
                        color: tile.selected
                            ? tile.colorSelect
                            : Colors.transparent,
                        width: 3,
                      ),
                      image: tile.game.hasImage
                          ? DecorationImage(
                              image: FileImage(File(tile.game.image)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: Stack(
                      children: [
                        if (!tile.game.hasImage)
                          Center(child: noImage(tile.game)),
                        if (tile.game.isFavorite)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: SvgPicture(
                                  getLoader(favoriteSVG),
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
