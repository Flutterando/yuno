// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';
import 'package:yuno/app/interactor/repositories/platform_repository.dart';
import 'package:yuno/app/interactor/repositories/sync_repository.dart';
import 'package:yuno/injector.dart';

import '../atoms/platform_atom.dart';
import '../models/embeds/game.dart';
import 'game_action.dart';

Future<void> firstInitialization(BuildContext context) async {
  await fetchPlatforms();
  await precacheGameImages(context);
}

Future<void> fetchPlatforms() async {
  final repository = injector<PlatformRepository>();
  final platforms = await repository.fetchPlatforms();
  platformsState.value = platforms;
}

Future<void> createPlatform(PlatformModel platform) async {
  final repository = injector<PlatformRepository>();
  final games = await _getGames(platform);
  platform = platform.copyWith(games: games);
  await repository.createPlatform(platform);
  await fetchPlatforms();
}

Future<List<Game>> _getGames(PlatformModel platform) async {
  if (platform.category.id == 'android') {
    return platform.games;
  }

  final games = <Game>[];
  final media = MediaStore();

  final documents = await media.getDocumentTree(uriString: platform.folder);

  if (documents == null) {
    return [];
  }

  final files = documents //
      .children
      .where((doc) {
    return platform.category.checkFileExtension(doc.name ?? '');
  }).toList();

  for (var file in files) {
    games.add(Game(
      name: cleanName(file.name ?? ''),
      path: file.uriString ?? '',
      description: '',
      image: '',
    ));
  }

  return games;
}

Future<void> syncPlatform(PlatformModel platform) async {
  if (isPlatformSyncing) {
    return;
  }

  platformSyncState.value = {...platformSyncState.value, platform.id};

  final repository = injector<SyncRepository>();

  for (var i = 0; i < platform.games.length; i++) {
    if (platform.games[i].isSynced) continue;
    if (platform.games[i].image.isNotEmpty) {
      final color = await getDominatingColor(platform.games[i].image);
      platform.games[i] = platform.games[i].copyWith(imageColor: color);
    } else {
      try {
        var metaGame = await repository.syncIGDB(platform.games[i]);
        final color = await getDominatingColor(metaGame.image);
        metaGame = metaGame.copyWith(imageColor: color);
        platform.games[i] = metaGame;
      } catch (e) {
        continue;
      }
    }
  }

  await updatePlatform(platform);
  platformSyncState.value.remove(platform.id);
  platformSyncState();
}

Future<Color?> getDominatingColor(String imagePath) async {
  final imageFile = File(imagePath);
  if (!imageFile.existsSync()) {
    return null;
  }
  final scheme = await ColorScheme.fromImageProvider(
    provider: FileImage(imageFile),
    brightness: Brightness.dark,
  );
  return scheme.primary;
}

String cleanName(String name) {
  final index = name.indexOf(RegExp(r'[.(\[]')) - 1;
  return name.substring(0, index <= 0 ? name.length : index).trim();
}

Future<void> updatePlatform(PlatformModel platform) async {
  final repository = injector<PlatformRepository>();
  await repository.updatePlatform(platform);
  await fetchPlatforms();
}

Future<void> deletePlatform(PlatformModel platform) async {
  final repository = injector<PlatformRepository>();
  await repository.deletePlatform(platform);
  await fetchPlatforms();
}

String convertContentUriToFilePath(String contentUri) {
  Uri uri = Uri.parse(contentUri);

  if (uri.authority == "com.android.externalstorage.documents") {
    String path = Uri.decodeComponent(uri.path);

    path = path.split(':').last;
    path = '/storage/emulated/0/$path';

    return path;
  } else {
    return contentUri;
  }
}
