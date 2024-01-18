import 'package:yuno/app/interactor/models/embeds/player.dart';

import '../models/embeds/game.dart';

PlayerIntent? getAppIntent(Game game, Player player) {
  return _defaultAppIntent[player.app.package]?.parse(player, game);
}

final _defaultAppIntent = <String, PlayerIntent>{
  'xyz.aethersx2.android': PlayerIntent(
    action: 'android.intent.action.VIEW',
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
      'LIBRETRO':
          r'/data/data/com.retroarch.aarch64/cores/${extra}_libretro_android.so',
    },
  ),
  'com.yuzu.android': PlayerIntent(
    action: 'android.nfc.action.TECH_DISCOVERED',
    package: 'com.yuzu.android',
    componentName: 'com.yuzu.android.EmulationActivity',
    data: r'${fileGame}',
  ),
  'org.yuzu.yuzu_emu_ea': PlayerIntent(
    action: 'android.nfc.action.TECH_DISCOVERED',
    package: 'org.yuzu.yuzu_emu_ea',
    componentName: 'com.yuzu.android.EmulationActivity',
    data: r'${fileGame}',
  ),
  'switch.skyline.emu': PlayerIntent(
    action: 'android.intent.action.VIEW',
    package: 'switch.skyline.emu',
    componentName: 'switch.skyline.emu.EmulationActivity',
    data: r'${fileGame}',
  ),
};
