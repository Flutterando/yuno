// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';
import 'package:yuno/app/interactor/repositories/platform_repository.dart';
import 'package:yuno/app/interactor/repositories/sync_repository.dart';
import 'package:yuno/injector.dart';

import '../atoms/platform_atom.dart';
import '../models/embeds/game.dart';
import '../repositories/storage_repository.dart';
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

Future<String?> getDirectory([String? initialFolder]) async {
  final repository = injector<StorageRepository>();
  final uri = await repository.getDirectoryUri(initialFolder);
  return uri?.toString();
}

Future<List<Game>> _getGames(PlatformModel platform) async {
  if (platform.category.id == 'android') {
    return platform.games;
  }

  final games = <Game>[];
  final storageRepository = injector<StorageRepository>();

  await storageRepository.persistedUriPermissions();

  final canRead =
      await storageRepository.canReadFileByUri(Uri.parse(platform.folder));
  if (canRead) {
    await getDirectory(platform.folder);
  }

  final documents = await storageRepository.getDocumentTree(platform.folder);

  final files = documents //
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
  final storageRepository = injector<StorageRepository>();

  if (platform.category.id != 'android') {
    final folderGames = await _getGames(platform);
    final currentGames = platform.games;
    final games = syncGames(currentGames, folderGames);
    platform = platform.copyWith(games: games);
  }

  for (var i = 0; i < platform.games.length; i++) {
    if (platform.games[i].isSynced) continue;
    if (platform.games[i].image.isNotEmpty) {
      final color = await getDominatingColor(platform.games[i].image);
      platform.games[i] = platform.games[i].copyWith(imageColor: color);
    } else {
      Game metaGame = platform.games[i];

      var canRead = true;

      if (platform.category.id != 'android') {
        final coverFolder = platform.folderCover ?? platform.folder;
        canRead =
            await storageRepository.canReadFileByUri(Uri.parse(coverFolder));
        if (canRead) {
          await getDirectory(coverFolder);
        }
        metaGame = await repository.syncLocalFolder(
          metaGame,
          coverFolder,
        );
      }

      if (gameConfigState.value.coverFolder != null && !metaGame.isSynced) {
        canRead = await storageRepository
            .canReadFileByUri(Uri.parse(gameConfigState.value.coverFolder!));
        if (canRead != true) {
          await getDirectory(gameConfigState.value.coverFolder!);
        }
        metaGame = await repository.syncLocalFolder(
          metaGame,
          gameConfigState.value.coverFolder!,
        );
      }

      if (gameConfigState.value.enableIGDB && !metaGame.isSynced) {
        metaGame = await repository.syncIGDB(
          platform.games[i],
        );
      }

      final color = await getDominatingColor(metaGame.image);
      metaGame = metaGame.copyWith(imageColor: color);
      platform.games[i] = metaGame;
    }
  }

  await updatePlatform(platform);
  platformSyncState.value.remove(platform.id);
  platformSyncState();
}

List<Game> syncGames(List<Game> currentGames, List<Game> folderGames) {
  final games = <Game>[];

  for (var i = 0; i < folderGames.length; i++) {
    final folderGame = folderGames[i];
    final currentGame = currentGames.firstWhere(
      (game) => game.path == folderGame.path,
      orElse: () => folderGame,
    );
    games.add(currentGame);
  }

  games.removeWhere((game) {
    return folderGames.every((folderGame) => folderGame.path != game.path);
  });
  return games;
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
  var nameWithoutExt = name.replaceAll(RegExp(r'\.[^.]*$'), '');
  nameWithoutExt =
      nameWithoutExt.replaceAll(RegExp(r'\s*\(.*?\)\s*|\s*\[.*?\]\s*'), '');
  nameWithoutExt = nameWithoutExt.replaceAll(RegExp(r'\sv.*'), '');

  return nameWithoutExt.trim();
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
