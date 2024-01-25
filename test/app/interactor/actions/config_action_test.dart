import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/models/game_config.dart';
import 'package:yuno/app/interactor/repositories/config_repository.dart';

class MockConfigRepository extends Mock implements ConfigRepository {}

void main() {
  group('ConfigAction |', () {
    final repository = MockConfigRepository();
    final config = GameConfig(themeMode: ThemeMode.dark);
    test('Should save the configuration', () {
      when(() => repository.saveConfig(config)).thenAnswer((_) async {});

      expect(config.themeMode, ThemeMode.dark);
      expect(gameConfigState.value, isA<GameConfig>());
    });
  });
}
