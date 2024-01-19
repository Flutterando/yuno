import 'package:yuno/app/interactor/models/embeds/player.dart';

import '../models/embeds/game.dart';
import 'platform_action.dart';

typedef IntentFunction = PlayerIntent Function(Player, Game);

PlayerIntent? getAppIntent(Game game, Player player) {
  return _defaultAppIntent[player.app.package]?.call(player, game);
}

final _defaultAppIntent = <String, IntentFunction>{
  'xyz.aethersx2.android': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'xyz.aethersx2.android',
      componentName: 'xyz.aethersx2.android.EmulationActivity',
      arguments: {
        'bootPath': g.path,
      },
    );
  },
  'com.retroarch.aarch64': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.retroarch.aarch64',
      componentName: 'com.retroarch.browser.retroactivity.RetroActivityFuture',
      arguments: {
        'ROM': convertContentUriToFilePath(g.path),
        'LIBRETRO':
            '/data/data/com.retroarch.aarch64/cores/${p.extra}_libretro_android.so',
      },
    );
  },
  'org.yuzu.yuzu_emu': (p, g) {
    return PlayerIntent(
      action: 'android.nfc.action.TECH_DISCOVERED',
      package: 'org.yuzu.yuzu_emu',
      type: 'application/octet-stream',
      componentName: 'org.yuzu.yuzu_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  'org.yuzu.yuzu_emu.ea': (p, g) {
    return PlayerIntent(
      action: 'android.nfc.action.TECH_DISCOVERED',
      package: 'org.yuzu.yuzu_emu.ea',
      type: 'application/octet-stream',
      componentName: 'org.yuzu.yuzu_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  'switch.skyline.emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'switch.skyline.emu',
      componentName: 'switch.skyline.emu.EmulationActivity',
      data: g.path,
    );
  },
};
