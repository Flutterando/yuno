// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yuno/app/interactor/actions/player_action.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';

import '../atoms/game_atom.dart';
import '../models/embeds/game.dart';
import 'apps_action.dart' as appsAction;

Future<void> precacheGameImages(BuildContext context) async {
  for (var game in gamesState) {
    if (game.image.isEmpty) {
      debugPrint('Game "${game.name}" don\'t have a image');
      continue;
    }

    final fileImage = File(game.image);

    if (fileImage.existsSync()) {
      await precacheImage(FileImage(fileImage), context);
    } else {
      debugPrint('Image not found: ${game.path}');
    }
  }
}

Future<void> openGameWithPlayer(Game game) async {
  final platform =
      platformsState.value.firstWhere((p) => p.games.contains(game)).player;

  final selectedPlayer = game.overradedPlayer ?? platform;
  if (selectedPlayer == null) {
    return;
  }
  final intent = getAppIntent(game, selectedPlayer);
  if (intent == null) {
    await appsAction.openApp(selectedPlayer.app);
  } else {
    appsAction.openIntent(intent);
  }
}
