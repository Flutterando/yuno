import 'package:yuno/app/core/services/game_service.dart';

import 'game_category.dart';
import 'game_platform.dart';

class Game {
  final String id;
  final String name;
  final String description;
  final GamePlatform platform;
  final String image;
  final String path;
  final GameCategory category;
  final String? genre;
  final String? publisher;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.platform,
    required this.image,
    required this.path,
    required this.category,
    this.genre,
    this.publisher,
  });

  void executeGame(GameService service) {
    platform.execute(this, service);
  }
}
