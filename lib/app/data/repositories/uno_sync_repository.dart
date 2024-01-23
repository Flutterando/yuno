import 'dart:io';

import 'package:path/path.dart';
import 'package:uno/uno.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

import '../../core/constants/env.dart';
import '../../interactor/repositories/sync_repository.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class UnoSyncRepository implements SyncRepository {
  final Uno uno;

  UnoSyncRepository({required this.uno});

  @override
  Future<Game> syncIGDB(Game game) async {
    final response = await uno.post(
      'https://api.igdb.com/v4/games',
      headers: {
        'content-type': 'text/plain',
        'client-id': igdbClientId,
        'authorization': 'Bearer $igdbToken',
      },
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

    final dirPath = await pathProvider.getApplicationDocumentsDirectory();
    final imageName = basename(image);
    final pathSeparator = Platform.pathSeparator;
    final imageFile = File('${dirPath.path}$pathSeparator$imageName');

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
  }

  @override
  Future<Game> syncRAWG(Game game) {
    // TODO: implement syncRAWG
    throw UnimplementedError();
  }
}
