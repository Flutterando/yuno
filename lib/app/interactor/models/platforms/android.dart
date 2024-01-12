import 'package:yuno/app/core/services/game_service.dart';

import '../game.dart';
import '../game_platform.dart';

class Android extends GamePlatform {
  Android()
      : super(
          idApp: 'android',
          name: 'Android',
        );

  @override
  void execute(Game game, GameService service) async {
    service.launchApp(game.path);
  }
}
