import 'dart:ui';

import 'package:yuno/app/interactor/models/embeds/player.dart';

class Game {
  final Player? overradedPlayer;
  final String name;
  final String description;
  final String image;
  final Color? imageColor;
  final String path;
  final bool isFavorite;
  final String? genre;
  final bool isSynced;
  final String? publisher;

  bool get hasImage => image.isNotEmpty;

  Game({
    this.isFavorite = false,
    this.overradedPlayer,
    this.isSynced = false,
    required this.name,
    required this.description,
    required this.image,
    required this.path,
    this.imageColor,
    this.genre,
    this.publisher,
  });
}
