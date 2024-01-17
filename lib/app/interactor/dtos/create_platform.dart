import '../models/game_category.dart';
import '../models/player.dart';

class CreatePlatform {
  final Player player;
  final GameCategory category;
  final String name;
  final String folder;

  CreatePlatform({
    required this.player,
    required this.category,
    required this.name,
    required this.folder,
  });
}
