// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yuno/app/interactor/actions/platform_action.dart';
import 'package:yuno/app/interactor/actions/player_action.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';
import 'package:yuno/injector.dart';

import '../atoms/game_atom.dart';
import '../models/embeds/game.dart';
import '../repositories/storage_repository.dart';
import 'apps_action.dart' as apps_action;

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

PlatformModel getPlatformFromGame(Game game) {
  return platformsState.value.firstWhere((p) => p.games.contains(game));
}

Future<PlatformModel> updateGame(Game game, Game newGame) async {
  final platform = getPlatformFromGame(game);

  final index = platform.games.indexOf(game);
  platform.games[index] = newGame;
  await updatePlatform(platform);
  return platform;
}

Future<void> selectCover(Game game) async {
  final storageRepository = injector.get<StorageRepository>();

  final file =
      await storageRepository.selectFile(<String>['jpg', 'jpeg', 'png']);

  if (file == null) {
    return;
  }

  final bytes = await file.getBytes?.call();
  if (bytes == null) return;

  final divide = Platform.pathSeparator;

  final imagePath =
      '${await storageRepository.getApplicationImagesDirectory()}$divide${file.name}';

  final imageFile = File(imagePath);
  await imageFile.create(recursive: true);
  await imageFile.writeAsBytes(bytes);

  final color = await getDominatingColor(imagePath);

  await updateGame(game, game.copyWith(image: imagePath, imageColor: color));
}

String getExtensionFromMimeType(String mimeType) {
  switch (mimeType) {
    case 'image/jpeg':
    case 'image/jpg':
      return 'jpg';
    case 'image/png':
      return 'png';
    default:
      return 'unknown';
  }
}

Future<void> openGameWithPlayer(Game game) async {
  final player = getPlatformFromGame(game).player;

  final selectedPlayer = game.overradedPlayer ?? player;
  if (selectedPlayer == null) {
    return;
  }
  final intent = getAppIntent(game, selectedPlayer);
  if (intent == null) {
    await apps_action.openApp(selectedPlayer.app);
  } else {
    apps_action.openIntent(intent);
  }
}
