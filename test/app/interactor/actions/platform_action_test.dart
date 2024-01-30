import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yuno/app/interactor/actions/platform_action.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';
import 'package:yuno/app/interactor/repositories/platform_repository.dart';
import 'package:yuno/app/interactor/repositories/storage_repository.dart';
import 'package:yuno/injector.dart';

class PlatformRepositoryMock extends Mock implements PlatformRepository {}

class StorageRepositoryMock extends Mock implements StorageRepository {}

class BuildContextMock extends Mock implements BuildContext {}

void main() {
  setUpAll(() {
    registerInjectAndroidConfig(injector);
  });
  group('PlatformAction |', () {
    test('Uri to path', () {
      expect(
        convertContentUriToFilePath(
            'content://com.android.externalstorage.documents/tree/primary%3AEmulation%2Frooms%2Fsnes/document/primary%3AEmulation%2Frooms%2Fsnes'),
        '/storage/emulated/0/Emulation/rooms/snes',
      );
    });

    test('clean name', () {
      final megaman = cleanName('Mega Man Zero 3.zip');
      expect(megaman, 'Mega Man Zero 3');
    });

    test('Sync games add', () {
      final currentGames = [
        Game(
          name: 'game 1',
          description: 'aaa',
          image: '',
          path: '/path1',
        ),
        Game(
          name: 'game 2',
          description: 'aaa',
          image: '',
          path: '/path2',
        ),
      ];
      final folderGames = [
        Game(
          name: 'game 1',
          description: '',
          image: '',
          path: '/path1',
        ),
        Game(
          name: 'game 2',
          description: '',
          image: '',
          path: '/path2',
        ),
        Game(
          name: 'game 3',
          description: '',
          image: '',
          path: '/path3',
        ),
      ];

      final games = syncGames(currentGames, folderGames);
      expect(games.length, 3);
      expect(games[0].description, 'aaa');
      expect(games[1].description, 'aaa');
    });

    test('Sync games remove', () {
      final currentGames = [
        Game(
          name: 'game 1',
          description: 'aaa',
          image: '',
          path: '/path1',
        ),
        Game(
          name: 'game 2',
          description: 'aaa',
          image: '',
          path: '/path2',
        ),
      ];
      final folderGames = [
        Game(
          name: 'game 1',
          description: '',
          image: '',
          path: '/path1',
        ),
        Game(
          name: 'game 3',
          description: '',
          image: '',
          path: '/path3',
        ),
      ];

      final games = syncGames(currentGames, folderGames);
      expect(games.length, 2);
      expect(games[0].description, 'aaa');
      expect(games[1].description, '');
      expect(games[1].name, 'game 3');
    });

    test('Should fetch platform', () async {
      // Arrange
      final repository = PlatformRepositoryMock();
      final platform = PlatformModel.defaultInstance();
      when(() => repository.fetchPlatforms())
          .thenAnswer((_) => Future.value([platform]));
      injector.replaceInstance<PlatformRepository>(repository);
      //Act
      final result = fetchPlatforms();
      //Assert
      expect(platformsState.next(), completion([platform]));
      expect(result, completes);
    });
    test('Should update platform', () {
      // Arrange
      final platform = PlatformModel.defaultInstance();
      final repository = PlatformRepositoryMock();
      when(() => repository.updatePlatform(platform))
          .thenAnswer((_) => Future.value());
      when(() => repository.fetchPlatforms())
          .thenAnswer((invocation) => Future.value([platform]));
      injector.replaceInstance<PlatformRepository>(repository);
      //Act
      final result = updatePlatform(platform);
      //Assert
      expect(platformsState.next(), completion([platform]));
      expect(result, completes);
    });
    test('Should delete platform', () {
      // Arrange
      final platform = PlatformModel.defaultInstance();
      final repository = PlatformRepositoryMock();
      when(() => repository.deletePlatform(platform))
          .thenAnswer((_) => Future.value());
      when(() => repository.fetchPlatforms())
          .thenAnswer((_) => Future.value([]));
      injector.replaceInstance<PlatformRepository>(repository);
      //Act
      final result = deletePlatform(platform);
      //Assert
      expect(result, completes);
    });
    test('First initialization', () {
      final bContext = BuildContextMock();
      final repository = PlatformRepositoryMock();
      when(() => repository.fetchPlatforms())
          .thenAnswer((_) => Future.value([]));
      injector.replaceInstance<PlatformRepository>(repository);
      final result = firstInitialization(bContext);
      expect(result, completes);
    });
    test('Get Directory', () {
      final uri = Uri();
      final repository = StorageRepositoryMock();
      when(() => repository.getDirectoryUri(''))
          .thenAnswer((_) => Future.value(uri));
      injector.replaceInstance<StorageRepository>(repository);
      final result = getDirectory('');
      expect(result, completes);
    });
    test('Should not Get dominant color', () async {
      final result = getDominatingColor('');
      expect(result, completes);
    });
  });
}
