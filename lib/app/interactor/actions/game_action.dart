// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yuno/app/interactor/actions/player_action.dart';
import 'package:yuno/injector.dart';

import '../atoms/game_atom.dart';
import '../models/game.dart';
import '../repositories/game_repository.dart';
import 'apps_action.dart' as appsAction;

Future<void> fetchGamesAction() async {
  final repository = injector.get<GameRepository>();
  gamesState.value = await repository.getGames();
}

Future<void> precacheGameImages(BuildContext context) async {
  for (var game in gamesState.value) {
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

Future<void> firstInitialization(BuildContext context) async {
  await fetchGamesAction();
  await precacheGameImages(context);
}

Future<void> openGameWithPlayer(Game game) async {
  final platform = game.overradedPlatform ?? game.platform;
  final intent = getAppIntent(game, platform);
  if (intent == null) {
    if (platform.player != null) {
      await appsAction.openApp(platform.player!.app);
    }
  } else {
    appsAction.openIntent(intent);
  }
}
