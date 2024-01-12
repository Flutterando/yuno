import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:yuno/app/core/services/game_service.dart';

import '../game.dart';
import '../game_platform.dart';

class Retroarch extends GamePlatform {
  final String libretro;

  Retroarch(this.libretro)
      : super(
          idApp: 'com.retroarch.aarch64',
          name: 'Retroarch',
        );

  @override
  void execute(Game game, GameService service) async {
    final intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      package: idApp,
      componentName: 'com.retroarch.browser.retroactivity.RetroActivityFuture',
      flags: [
        Flag.FLAG_ACTIVITY_CLEAR_TASK,
        Flag.FLAG_ACTIVITY_CLEAR_TOP,
      ],
      arguments: {
        'ROM': game.path,
        'LIBRETRO': libretro,
      },
    );

    await intent.launch();
  }
}
