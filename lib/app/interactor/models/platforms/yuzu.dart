import 'package:yuno/app/interactor/repositories/apps_repository.dart';

import '../game.dart';
import '../game_platform.dart';

class Yuzu extends GamePlatform {
  Yuzu()
      : super(
          idApp: 'com.yuzu.android',
          name: 'Nintendo Switch',
        );

  @override
  Future<void> execute(Game game, AppsRepository appsRepository) {
    return appsRepository.openWithCustomConfig(
      action: 'android.intent.action.MAIN',
      package: idApp,
      componentName: 'com.yuzu.android.EmulationActivity',
      arguments: {
        'bootPath': game.path,
      },
    );
  }
}
