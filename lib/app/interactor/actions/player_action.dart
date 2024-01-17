import 'package:yuno/app/interactor/models/player.dart';

import '../models/game.dart';
import '../models/platform_model.dart';

PlayerIntent? getAppIntent(Game game, PlatformModel platform) {
  return _defaultAppIntent[platform.player?.app.package]?.parse(game);
}

final _defaultAppIntent = <String, PlayerIntent>{
  'xyz.aethersx2.android': PlayerIntent(
    action: 'android.intent.action.MAIN',
    package: 'xyz.aethersx2.android',
    componentName: 'xyz.aethersx2.android.EmulationActivity',
    arguments: {
      'bootPath': r'${fileGame}',
    },
  ),
  'com.retroarch.aarch64': PlayerIntent(
    action: 'android.intent.action.MAIN',
    package: 'com.retroarch.aarch64',
    componentName: 'com.retroarch.browser.retroactivity.RetroActivityFuture',
    arguments: {
      'ROM': r'${fileGame}',
      'LIBRETRO': r'${extra}',
    },
  ),
  'com.yuzu.android': PlayerIntent(
    action: 'android.intent.action.MAIN',
    package: 'com.yuzu.android',
    componentName: 'com.yuzu.android.EmulationActivity',
    arguments: {
      'ROM': r'${fileGame}',
    },
  ),
};
