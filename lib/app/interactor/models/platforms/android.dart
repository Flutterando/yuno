import 'dart:typed_data';

import 'package:yuno/app/interactor/models/app_model.dart';

import '../../repositories/apps_repository.dart';
import '../game.dart';
import '../game_platform.dart';

class Android extends GamePlatform {
  Android()
      : super(
          idApp: 'android',
          name: 'Android',
        );

  @override
  Future<void> execute(Game game, AppsRepository appsRepository) {
    return appsRepository.openApp(
      AppModel(name: game.name, package: game.path, icon: Uint8List(0)),
    );
  }
}
