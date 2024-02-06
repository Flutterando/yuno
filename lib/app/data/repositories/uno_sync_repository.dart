import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uno/uno.dart';
import 'package:yuno/app/interactor/actions/platform_action.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

import '../../core/constants/env.dart';
import '../../interactor/repositories/sync_repository.dart';

class UnoSyncRepository implements SyncRepository {
  final Uno uno;
  final MediaStore media;

  UnoSyncRepository._({required this.uno, required this.media});

  factory UnoSyncRepository() {
    return UnoSyncRepository._(
      uno: Uno(),
      media: MediaStore(),
    );
  }

  @override
  Future<Game> syncLocalFolder(Game game, String coverFolder) async {
    try {
      final documents = await media.getDocumentTree(uriString: coverFolder);

      if (documents == null) {
        return game;
      }

      final files = documents //
          .children
          .where(
        (doc) {
          final name = doc.name?.toLowerCase();
          if (name == null) {
            return false;
          }
          return name.endsWith('.png') ||
              name.endsWith('.jpg') ||
              name.endsWith('.jpeg');
        },
      ).toList();

      if (files.isEmpty) {
        return game;
      }

      final gameName =
          basenameWithoutExtension(convertContentUriToFilePath(game.path));

      final file = files.firstWhereOrNull((doc) {
        final name = doc.name!;
        return name.startsWith(gameName);
      });

      if (file == null) {
        return game;
      }

      final dirPath = await path_provider.getApplicationDocumentsDirectory();
      final imageName = file.name!;
      final pathSeparator = Platform.pathSeparator;
      final imageFile = File('${dirPath.path}${pathSeparator}local_$imageName');
      if (imageFile.existsSync()) {
        await imageFile.delete();
      }
      await media.readFileUsingUri(
          uriString: file.uriString, tempFilePath: imageFile.path);
      return game.copyWith(image: imageFile.path, isSynced: true);
    } catch (e) {
      debugPrint(e.toString());
      return game;
    }
  }

  @override
  Future<Game> syncIGDB(Game game) async {
    try {
      final response = await uno.post(
        'https://api.igdb.com/v4/games',
        headers: {
          'content-type': 'text/plain',
          'client-id': igdbClientId,
          'authorization': 'Bearer $igdbToken',
        },
        timeout: const Duration(seconds: 5),
        data:
            'fields artworks,collection,cover.*, first_release_date,genres.*,name,summary; search "${game.name}"; limit 2;',
      );

      // prevent multiples calls
      await Future.delayed(const Duration(seconds: 1));

      if (response.data.isEmpty) {
        return game;
      }

      final json = response.data[0];

      var image = "https:${json['cover']['url']}";
      image = image.replaceAll('t_thumb', 't_cover_big');

      final dirPath = await path_provider.getApplicationDocumentsDirectory();
      final imageName = basename(image);
      final pathSeparator = Platform.pathSeparator;
      final imageFile = File('${dirPath.path}${pathSeparator}igdb_$imageName');

      if (!imageFile.existsSync()) {
        final imageData =
            await uno.get(image, responseType: ResponseType.arraybuffer);
        await imageFile.writeAsBytes(imageData.data);
      }

      final metaGame = game.copyWith(
        isSynced: true,
        description: json['summary'],
        image: imageFile.path,
        genre: json['genres'][0]['name'],
      );

      return metaGame;
    } catch (e) {
      debugPrint(e.toString());
      return game;
    }
  }

  @override
  Future<Game> syncRAWG(Game game) {
    // TODO: implement syncRAWG
    throw UnimplementedError();
  }
}
