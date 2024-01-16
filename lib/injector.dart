import 'dart:io';

import 'package:auto_injector/auto_injector.dart';
import 'package:yuno/app/data/services/gamepad/android_gamepad_service.dart';
import 'package:yuno/app/interactor/services/gamepad_service.dart';

import 'app/data/apps/android_apps_repository.dart';
import 'app/data/mocks/mock_game_repository.dart';
import 'app/data/share_preferences/shared_preference_config_repository.dart';
import 'app/interactor/repositories/apps_repository.dart';
import 'app/interactor/repositories/config_repository.dart';
import 'app/interactor/repositories/game_repository.dart';

final injector = AutoInjector(
  on: (i) {
    i.addSingleton<GameRepository>(MockGameRepository.new);
    i.addSingleton<ConfigRepository>(SharedPreferenceConfigRepository.new);

    _androidConfig(i);
  },
);

void _androidConfig(Injector i) {
  if (!Platform.isAndroid) return;
  i.addSingleton<AppsRepository>(AndroidAppsRepository.new);
  i.addSingleton<GamepadService>(AndroidGamepadService.new);
}
