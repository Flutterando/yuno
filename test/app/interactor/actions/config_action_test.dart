import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/models/game_config.dart';
import 'package:yuno/app/interactor/repositories/config_repository.dart';
import 'package:yuno/injector.dart';

class ConfigRepositoryMock extends Mock implements ConfigRepository {}

void main() {
  group('ConfigAction |', () {
    final config = GameConfig(themeMode: ThemeMode.dark);
    test('Should save the configuration', () async {
      //Arrange
      final repository = ConfigRepositoryMock();
      when(() => repository.saveConfig(config))
          .thenAnswer((_) => Future.value());
      injector.replaceInstance<ConfigRepository>(repository);
      //Act
      final result = saveConfig(config);
      //Assert
      expect(gameConfigState.next(), completion(config));
      expect(result, completes);
    });

    test('Should fetchConfig', () async {
      // Arrange
      final repository = ConfigRepositoryMock();
      when(() => repository.getConfig())
          .thenAnswer((_) => Future.value(config));
      injector.replaceInstance<ConfigRepository>(repository);
      //Act
      final result = fetchConfig();
      //Assert
      expect(gameConfigState.next(), completion(config));
      expect(result, completes);
    });

    test('Should Open Url', () {
      //Arrange
      final uri = Uri.https('localhost.com', '/home');
      final repository = ConfigRepositoryMock();
      when(() => repository.openUrl(uri)).thenAnswer((_) => Future.value());
      injector.replaceInstance<ConfigRepository>(repository);
      //Act
      final result = openUrl(uri);
      //Assert
      expectLater(result, completes);
    });
  });
}
