import 'dart:io';

import 'package:yuno/app/interactor/models/game_category.dart';

import 'player.dart';

class PlatformModel {
  final int id;
  final GameCategory category;
  final Player? player;
  final Directory folder;
  final DateTime lastUpdate;

  PlatformModel({
    required this.id,
    required this.folder,
    this.player,
    required this.lastUpdate,
    required this.category,
  });

  PlatformModel copyWith({
    Player? player,
    String? name,
    Directory? folder,
    DateTime? lastUpdate,
    GameCategory? category,
    String? playerArguments,
  }) {
    return PlatformModel(
      id: id,
      category: category ?? this.category,
      player: player ?? this.player,
      folder: folder ?? this.folder,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
