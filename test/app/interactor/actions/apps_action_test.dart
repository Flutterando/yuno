import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yuno/app/interactor/actions/apps_action.dart';
import 'package:yuno/app/interactor/atoms/app_atom.dart';
import 'package:yuno/app/interactor/models/app_model.dart';
import 'package:yuno/app/interactor/models/embeds/player.dart';
import 'package:yuno/app/interactor/repositories/apps_repository.dart';
import 'package:yuno/injector.dart';

class AppsRepositoryMock extends Mock implements AppsRepository {}

class AppModelFake extends Fake implements AppModel {}

void main() {
  late var repository = AppsRepositoryMock();

  setUpAll(() {
    registerInjectAndroidConfig(injector);
  });
  setUp(() {
    repository = AppsRepositoryMock();
  });
  group('AppAction |', () {
    test('Should open App', () {
      //Arrange
      final model = AppModelFake();
      when(() => repository.openApp(model)).thenAnswer((_) => Future.value());
      injector.replaceInstance<AppsRepository>(repository);
      //Act
      final result = openApp(model);
      //Assert
      expect(result, completes);
    });
    test('Should open app settings', () {
      //Arrange
      final model = AppModelFake();
      when(() => repository.openAppSettings(model))
          .thenAnswer((_) => Future.value());
      injector.replaceInstance<AppsRepository>(repository);
      //Act
      final result = openAppSettings(model);
      //Assert
      expect(result, completes);
    });
    test('Should open configuration', () {
      //Arrange
      when(() => repository.openConfiguration())
          .thenAnswer((_) => Future.value());
      injector.replaceInstance<AppsRepository>(repository);
      //Act
      final result = openConfiguration();
      //Assert
      expect(result, completes);
    });
    test('Should open intent', () {
      //Arrange
      final intent = PlayerIntent(action: '', package: '');
      when(() => repository.openIntent(intent))
          .thenAnswer((_) => Future.value());
      injector.replaceInstance<AppsRepository>(repository);
      //Act
      final result = openIntent(intent);
      //Assert
      expect(result, completes);
    });

    test('Should fetch apps', () {
      //Arrange
      final model = AppModelFake();
      when(() => repository.getInstalledApps())
          .thenAnswer((_) => Future.value({model}));
      injector.replaceInstance<AppsRepository>(repository);
      //Act
      final result = fetchApps();
      //Assert
      expect(result, completes);
      verify(() => repository.getInstalledApps()).called(1);
    });

    test('Should register install and uninstall app', () async {
      final controller = StreamController<String>.broadcast();

      when(() => repository.installAndUninstallListener())
          .thenAnswer((_) => controller.stream);
      when(() => repository.getInstalledApps())
          .thenAnswer((invocation) => Future.value({}));
      injector.replaceInstance<AppsRepository>(repository);
      await registerInstallAndUninstallAppListener();
      await registerInstallAndUninstallAppListener();

      expect(appsState.next(), completes);
      controller.add('banana');
    });
  });
}
