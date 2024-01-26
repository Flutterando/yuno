import 'dart:ui';

import 'package:yuno/app/data/repositories/isar/db/platform_data.dart';
import 'package:yuno/app/interactor/atoms/game_atom.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

import '../../../../interactor/atoms/app_atom.dart';
import '../../../../interactor/models/embeds/player.dart';
import '../../../../interactor/models/platform_model.dart';
import '../db/game_data.dart';

abstract class PlatformAdapter {
  static PlatformData platformFromModel(PlatformModel model) {
    final data = PlatformData();

    if (model.id != -1) {
      data.id = model.id;
    }

    data.category = model.category.id;

    final games = model.games.map((e) => gameFromModel(e)).toList();
    games.sort((a, b) => a.name.compareTo(b.name));
    data.games = games;
    data.folder = model.folder;
    data.lastUpdate = DateTime.now();
    data.playerPackageId = model.player?.app.package;
    data.playerExtra = model.player?.extra;
    data.folderCover = model.folderCover;
    return data;
  }

  static GameData gameFromModel(Game model) {
    final data = GameData();
    data.path = model.path;
    data.name = model.name;
    data.overradedPlayer = model.overradedPlayer?.toJson();
    data.description = model.description;
    data.image = model.image;
    data.imageColor = model.imageColor?.value.toRadixString(16);
    data.isFavorite = model.isFavorite;
    data.isSynced = model.isSynced;
    data.genre = model.genre;
    data.publisher = model.publisher;
    return data;
  }

  static PlatformModel platformFromData(PlatformData model) {
    return PlatformModel(
      id: model.id,
      folder: model.folder,
      lastUpdate: model.lastUpdate,
      category: categorieState.firstWhere((e) => e.id == model.category),
      player: model.playerPackageId == null
          ? null
          : Player(
              app: appsState.value
                  .firstWhere((e) => e.package == model.playerPackageId),
              extra: model.playerExtra,
            ),
      games: model.games.map((e) => gameFromData(e)).toList(),
      folderCover: model.folderCover,
    );
  }

  static Game gameFromData(GameData model) {
    return Game(
      name: model.name,
      description: model.description,
      image: model.image ?? '',
      path: model.path,
      imageColor: model.imageColor == null
          ? null
          : Color(int.parse(model.imageColor!, radix: 16)),
      isFavorite: model.isFavorite,
      isSynced: model.isSynced,
      genre: model.genre,
      publisher: model.publisher,
      overradedPlayer: model.overradedPlayer == null
          ? null
          : Player.fromJson(model.overradedPlayer!),
    );
  }
}
