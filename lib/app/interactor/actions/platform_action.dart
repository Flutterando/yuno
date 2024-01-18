import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';
import 'package:yuno/app/interactor/repositories/platform_repository.dart';
import 'package:yuno/injector.dart';

import '../atoms/platform_atom.dart';
import '../models/embeds/game.dart';
import 'game_action.dart';

// igdp 1o179i97b6l23szlizbu6hdknrg9so

// > POST /v4/games HTTP/2
// > Host: api.igdb.com
// > cookie: __cf_bm=xO7z4BfO.LCPPT_pEgqUYYtKcOVWVUBxl3P.jWEVYJY-1705531429-1-ARyT4iQbBQJYySOWqftllPZL9zE+kTmThYfHMqkmO6koa5Xzts+qtg/4q1WLKx0X56SwKAF85f1s2f/bxYZcAXQ=
// > content-type: text/plain
// > user-agent: insomnia/2023.5.8
// > client-id: tmj9jsx0fuamcftxqecvsybnoh59lm
// > authorization: Bearer 1o179i97b6l23szlizbu6hdknrg9so
// > accept: */*
// > content-length: 114
// fields artworks,collection,cover.*, first_release_date,genres.*,name,summary; search "super mario world"; limit 1;

// rawg 09c741277de347b79d8cbb55ec394b54

//GET /api/games?key=09c741277de347b79d8cbb55ec394b54&search=Super%20mario%20odyssey HTTP/2
//> Host: api.rawg.io
//> user-agent: insomnia/2023.5.8
//> accept: */*

Future<void> firstInitialization(BuildContext context) async {
  await fetchPlatforms();
  await precacheGameImages(context);
}

Future<void> fetchPlatforms() async {
  final repository = injector<PlatformRepository>();
  platformsState.value = await repository.fetchPlatforms();
}

Future<void> createPlatform(PlatformModel platform) async {
  final repository = injector<PlatformRepository>();
  final games = await _getGames(platform);
  platform = platform.copyWith(games: games);

  //await repository.createPlatform(platform);
  //await fetchPlatforms();
}

Future<List<Game>> _getGames(PlatformModel platform) async {
  if (platform.category.id == 'android') {
    return platform.games;
  }

  final games = <Game>[];
  final directory =
      Directory(convertContentUriToFilePath(platform.folder.path));
  final files = directory //
      .listSync()
      .whereType<File>()
      .toList();

  for (var file in files) {
    print(file);
  }

  return games;
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

Future<void> syncPlatform(PlatformModel platform) async {}

String addFileInUri(String dirUri, String fileName) {
  String path = Uri.encodeComponent(dirUri);
  path = path.replaceAll('/storage/emulated/0/', 'primary:');
  return 'content://com.android.externalstorage.documents/document/$path';
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
