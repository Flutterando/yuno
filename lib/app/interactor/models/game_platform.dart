import 'package:yuno/app/interactor/models/platforms/aethersx2.dart';
import 'package:yuno/app/interactor/models/platforms/android.dart';
import 'package:yuno/app/interactor/repositories/apps_repository.dart';

import 'game.dart';

abstract class GamePlatform {
  final String idApp;
  final String name;

  GamePlatform({
    required this.idApp,
    required this.name,
  });

  static GamePlatform byAppId(String idApp) {
    return [AetherSX2(), Android()]
        .firstWhere((element) => element.idApp == idApp);
  }

  Future<void> execute(Game game, AppsRepository appsRepository);
}
