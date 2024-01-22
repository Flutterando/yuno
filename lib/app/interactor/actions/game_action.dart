// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:yuno/app/interactor/actions/platform_action.dart';
import 'package:yuno/app/interactor/actions/player_action.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';

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
  const XTypeGroup typeGroup = XTypeGroup(
    label: 'images',
    extensions: <String>['jpg', 'png'],
  );
  final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

  if (file == null) {
    return;
  }

  final extension = getExtensionFromMimeType(file.mimeType!);
  final name = '${DateTime.now().millisecondsSinceEpoch}.$extension';
  final divide = Platform.pathSeparator;

  final imagePath =
      '${(await pathProvider.getApplicationDocumentsDirectory()).path}${divide}images${divide}${name}';
  print(imagePath);

  final bytes = await file.readAsBytes();
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
    await appsAction.openApp(selectedPlayer.app);
  } else {
    appsAction.openIntent(intent);
  }
}
