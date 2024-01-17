import 'dart:ui';

import 'game_category.dart';
import 'platform_model.dart';

class Game {
  final int id;
  final PlatformModel platform;
  final PlatformModel? overradedPlatform;
  final String name;
  final String description;
  final String image;
  final Color? imageColor;
  final String path;
  final Set<GameCategory> categories;
  final String? genre;
  final String? publisher;

  bool get hasImage => image.isNotEmpty;

  Game({
    required this.id,
    required this.platform,
    this.overradedPlatform,
    required this.name,
    required this.description,
    required this.image,
    required this.path,
    this.imageColor,
    this.categories = const {},
    this.genre,
    this.publisher,
  });
}
