import '../models/embeds/game_category.dart';
import '../models/embeds/player.dart';

class CreatePlatform {
  final Player? player;
  final GameCategory category;
  final String folder;
  final List<String> androidApps;

  CreatePlatform({
    required this.androidApps,
    this.player,
    required this.category,
    required this.folder,
  });
}
