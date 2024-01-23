import 'package:yuno/app/interactor/models/embeds/game_category.dart';

import 'embeds/game.dart';
import 'embeds/player.dart';

class PlatformModel {
  final int id;
  final GameCategory category;
  final Player? player;
  final String folder;
  final List<Game> games;

  final DateTime lastUpdate;

  PlatformModel({
    required this.id,
    required this.folder,
    this.player,
    required this.lastUpdate,
    required this.category,
    required this.games,
  });

  String? validator() {
    if (category.name.isEmpty) {
      return 'You must select a category';
    }
    if (category.id == 'android' && games.isEmpty) {
      return 'You must select at least one app';
    }

    if (category.id != 'android' && player == null) {
      return 'Select a player';
    }

    if (category.id != 'android' //
        &&
        player != null &&
        player!.app.package.startsWith('com.retroarch') &&
        player!.extra == null) {
      return 'Select a Retroarch Core';
    }

    if (category.id != 'android' && folder.isEmpty) {
      return 'Folder cannot be empty';
    }

    return null;
  }

  static PlatformModel defaultInstance() {
    return PlatformModel(
      id: -1,
      folder: '',
      lastUpdate: DateTime.now(),
      games: [],
      category: GameCategory(name: '', image: '', id: ''),
    );
  }

  PlatformModel copyWith(
      {Player? player,
      String? name,
      String? folder,
      DateTime? lastUpdate,
      GameCategory? category,
      String? playerArguments,
      List<Game>? games}) {
    return PlatformModel(
      id: id,
      category: category ?? this.category,
      player: player ?? this.player,
      games: games ?? this.games,
      folder: folder ?? this.folder,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
