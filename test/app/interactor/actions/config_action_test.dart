import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/models/battery_model.dart';
import 'package:yuno/app/interactor/models/game_config.dart';
import 'package:yuno/app/interactor/repositories/config_repository.dart';
import 'package:yuno/app/interactor/repositories/device_repository.dart';
import 'package:yuno/injector.dart';

class ConfigRepositoryMock extends Mock implements ConfigRepository {}

class DeviceRepositoryMock extends Mock implements DeviceRepository {}

void main() {
  setUpAll(() {
    registerInjectAndroidConfig(injector);
  });
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

    test('Should fetchConfig', () {
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

    test('Should Open Url', () async {
      //Arrange
      final uri = Uri.https('localhost.com', '/home');
      final repository = ConfigRepositoryMock();
      when(() => repository.openUrl(uri)).thenAnswer((_) => Future.value());
      injector.replaceInstance<ConfigRepository>(repository);
      //Act
      final result = openUrl(uri);
      //Assert
      await expectLater(result, completes);
      verify(() => repository.openUrl(uri)).called(1);
    });
    test('Beautify Path', () {
      final result = beautifyPath('path');
      expect(result, "path");
    });
    test('Register Battery Listener', () async {
      final stController = StreamController<BatteryModel>.broadcast();
      final repository = DeviceRepositoryMock();
      when(() => repository.batteryStatus())
          .thenAnswer((_) => stController.stream);
      injector.replaceInstance<DeviceRepository>(repository);
      await registerBatteryListener();
      await registerBatteryListener();

      expect(batteryState.next(), completes);
      stController.add(BatteryModel(
          batteryLevel: 12, batteryState: BatteryState.discharging));
    });

    test("Register Hour Listener", () {
      registerHourListener();
      expect(hoursState.next(), completes);
    });
  });
}
