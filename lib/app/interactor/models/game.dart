import 'dart:ui';

import '../repositories/apps_repository.dart';
import 'game_category.dart';
import 'game_platform.dart';

class Game {
  final String id;
  final String name;
  final String description;
  final GamePlatform platform;
  final String image;
  final Color? imageColor;
  final String path;
  final Set<GameCategory> category;
  final String? genre;
  final String? publisher;

  bool get hasImage => image.isNotEmpty;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.platform,
    required this.image,
    required this.path,
    this.imageColor,
    this.category = const {},
    this.genre,
    this.publisher,
  });

  Future<void> execute(AppsRepository appsRepository) {
    return platform.execute(this, appsRepository);
  }
}
