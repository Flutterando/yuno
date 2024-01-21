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

  Game removeOverridedPlayer() {
    return Game(
      name: name,
      imageColor: imageColor,
      description: description,
      image: image,
      path: path,
      isFavorite: isFavorite,
      genre: genre,
      isSynced: isSynced,
      publisher: publisher,
    );
  }

  Game copyWith({
    Player? overradedPlayer,
    String? name,
    String? description,
    String? image,
    String? path,
    bool? isFavorite,
    Color? imageColor,
    String? genre,
    bool? isSynced,
    String? publisher,
  }) {
    return Game(
      overradedPlayer: overradedPlayer ?? this.overradedPlayer,
      name: name ?? this.name,
      imageColor: imageColor ?? this.imageColor,
      description: description ?? this.description,
      image: image ?? this.image,
      path: path ?? this.path,
      isFavorite: isFavorite ?? this.isFavorite,
      genre: genre ?? this.genre,
      isSynced: isSynced ?? this.isSynced,
      publisher: publisher ?? this.publisher,
    );
  }
}
