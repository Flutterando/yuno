import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:yuno/app/core/services/game_service.dart';

import '../game.dart';
import '../game_platform.dart';

class AetherSX2 extends GamePlatform {
  AetherSX2()
      : super(
          idApp: 'xyz.aethersx2.android',
          name: 'PlayStation 2',
        );

  @override
  void execute(Game game, GameService service) async {
    final intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      package: idApp,
      componentName: 'xyz.aethersx2.android.EmulationActivity',
      flags: [
        Flag.FLAG_ACTIVITY_CLEAR_TASK,
        Flag.FLAG_ACTIVITY_CLEAR_TOP,
      ],
      arguments: {
        'bootPath': game.path,
      },
    );

    intent.launch();
  }
}
