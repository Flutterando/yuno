import 'package:yuno/app/interactor/models/embeds/player.dart';

import '../models/embeds/game.dart';
import 'platform_action.dart';

typedef IntentFunction = PlayerIntent Function(Player, Game);

PlayerIntent? getAppIntent(Game game, Player player) {
  return _defaultAppIntent[player.app.package]?.call(player, game);
}

bool isAppIntentSupported(String package) {
  return _defaultAppIntent.containsKey(package);
}

final _defaultAppIntent = <String, IntentFunction>{
  'com.retroarch.aarch64': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.retroarch.aarch64',
      componentName: 'com.retroarch.browser.retroactivity.RetroActivityFuture',
      arguments: {
        'ROM': convertContentUriToFilePath(g.path),
        'LIBRETRO':
            '/data/data/com.retroarch.aarch64/cores/${p.extra}_libretro_android.so',
        'CONFIGFILE':
            '/storage/emulated/0/Android/data/com.retroarch.aarch64/files/retroarch.cfg',
        'DATADIR': '/data/data/com.retroarch.aarch64',
        'APK': '/data/app/com.retroarch.aarch64-1/base.apk',
        'SDCARD': '/storage/emulated/0',
        'EXTERNAL':
            '/storage/emulated/0/Android/data/com.retroarch.aarch64/files',
        'IME': 'com.android.inputmethod.latin/.LatinIME',
      },
    );
  },
  'com.retroarch': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.retroarch',
      componentName: 'com.retroarch.browser.retroactivity.RetroActivityFuture',
      arguments: {
        'ROM': convertContentUriToFilePath(g.path),
        'LIBRETRO':
            '/data/data/com.retroarch/cores/${p.extra}_libretro_android.so',
        'CONFIGFILE':
            '/storage/emulated/0/Android/data/com.retroarch/files/retroarch.cfg',
        'DATADIR': '/data/data/com.retroarch',
        'APK': '/data/app/com.retroarch-1/base.apk',
        'SDCARD': '/storage/emulated/0',
        'EXTERNAL': '/storage/emulated/0/Android/data/com.retroarch/files',
        'IME': 'com.android.inputmethod.latin/.LatinIME',
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
  'org.ppsspp.ppsspp': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.ppsspp.ppsspp',
      type: 'application/octet-stream',
      category: 'android.intent.category.DEFAULT',
      componentName: 'org.ppsspp.ppsspp.PpssppActivity',
      data: g.path,
    );
  },
  'org.ppsspp.ppssppgold': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.ppsspp.ppssppgold',
      type: 'application/octet-stream',
      category: 'android.intent.category.DEFAULT',
      componentName: 'org.ppsspp.ppsspp.PpssppActivity',
      data: g.path,
    );
  },
  'com.explusalpha.Snes9xPlus': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.explusalpha.Snes9xPlus',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
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
  'xyz.aethersx2.custom': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'xyz.aethersx2.custom',
      componentName: 'xyz.aethersx2.custom.EmulationActivity',
      arguments: {'bootPath': g.path},
    );
  },
  'com.antutu.ABenchMark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.antutu.ABenchMark',
      componentName: 'org.citra.emu.ui.EmulationActivity',
      arguments: {'GamePath': g.path},
    );
  },
  'com.antutu.SAABenchMark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.antutu.SAABenchMark',
      componentName: 'org.citra.emu.ui.EmulationActivity',
      arguments: {'GamePath': g.path},
    );
  },
  'org.citra.nightly': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.citra.nightly',
      componentName: 'org.citra.citra_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  'org.citra.canary': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.citra.canary',
      componentName: 'org.citra.citra_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  'org.citra.emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.citra.emu',
      componentName: 'org.citra.emu.ui.EmulationActivity',
      arguments: {'GamePath': g.path},
    );
  },
  'org.citra.citra_emu.canary': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.citra.citra_emu.canary',
      componentName: 'org.citra.citra_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  'org.citra.citra_emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.citra.citra_emu',
      componentName: 'org.citra.citra_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  'com.explusalpha.MdEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.explusalpha.MdEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'skyline.emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'skyline.emu',
      componentName: 'emu.skyline.EmulationActivity',
      data: g.path,
    );
  },
  'strato.yosho': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'strato.yosho',
      componentName: 'emu.skyline.EmulationActivity',
      data: g.path,
    );
  },
  'org.dolphinemu.handheld': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.dolphinemu.handheld',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'org.mm.jr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.mm.jr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': convertContentUriToFilePath(g.path),
      },
    );
  },
  'org.mm.j': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.mm.j',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': convertContentUriToFilePath(g.path),
      },
    );
  },
  'org.dolphinemu.mmjr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.dolphinemu.mmjr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'org.dolphinemu.dolphinemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'org.dolphinemu.dolphinemu',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'org.dolphinemu.mmjr3': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.dolphinemu.mmjr3',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'org.dolphin.ishiirukadark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.dolphin.ishiirukadark',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'com.dsemu.drastic': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.dsemu.drastic',
      componentName: 'com.dsemu.drastic.DraSticActivity',
      data: g.path,
    );
  },
  'me.magnum.melonds': (p, g) {
    return PlayerIntent(
      action: 'me.magnum.melonds.LAUNCH_ROM',
      package: 'me.magnum.melonds',
      arguments: {'uri': g.path},
    );
  },
  'com.hydra.noods.FileBrowser': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.hydra.noods.FileBrowser',
      componentName: 'com.hydra.noods.FileBrowser.FileBrowser',
      arguments: {
        'LaunchPath': convertContentUriToFilePath(g.path),
      },
    );
  },
  'com.explusalpha.NesEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.explusalpha.NesEmu',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'com.androidemu.nes': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.androidemu.nes',
      componentName: 'com.androidemu.nes.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.explusalpha.PceEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.explusalpha.PceEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'org.mupen64plusae.v3.fzurita': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.mupen64plusae.v3.fzurita',
      componentName: 'paulscode.android.mupen64plusae.SplashActivity',
      data: g.path,
    );
  },
  'org.mupen64plusae.v3.alpha': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.mupen64plusae.v3.alpha',
      componentName: 'paulscode.android.mupen64plusae.SplashActivity',
      data: g.path,
    );
  },
  'org.mupen64plusae.v3.fzurita.pro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.mupen64plusae.v3.fzurita.pro',
      componentName: 'paulscode.android.mupen64plusae.SplashActivity',
      data: g.path,
    );
  },
  'paulscode.android.mupen64plusae': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'paulscode.android.mupen64plusae',
      componentName: 'paulscode.android.mupen64plusae.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'it.dbtecno.pizzaboy': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'it.dbtecno.pizzaboy',
      componentName: 'it.dbtecno.pizzaboy.MainActivity',
      arguments: {'rom_uri': convertContentUriToFilePath(g.path)},
    );
  },
  'it.dbtecno.pizzaboypro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'it.dbtecno.pizzaboypro',
      componentName: 'it.dbtecno.pizzaboypro.MainActivity',
      arguments: {'rom_uri': convertContentUriToFilePath(g.path)},
    );
  },
  'com.sky.SkyEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.sky.SkyEmu',
      componentName: 'com.sky.SkyEmu.EnhancedNativeActivity',
      data: g.path,
    );
  },
  'com.explusalpha.GbcEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.explusalpha.GbcEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'com.fastemulator.gbcfree': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.fastemulator.gbcfree',
      componentName: 'com.fastemulator.gbcfree.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.fastemulator.gbc': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.fastemulator.gbc',
      componentName: 'com.fastemulator.gbc.EmulatorActivity',
      data: g.path,
    );
  },
  'com.explusalpha.NeoEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.explusalpha.NeoEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'org.devmiyax.yabasanshioro2.pro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.devmiyax.yabasanshioro2.pro',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'org.devmiyax.yabasanshioro2': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.devmiyax.yabasanshioro2',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'org.uoyabause.android.pro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.uoyabause.android.pro',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'org.uoyabause.android': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'org.uoyabause.android',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'it.dbtecno.pizzaboygba': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'it.dbtecno.pizzaboygba',
      componentName: 'it.dbtecno.pizzaboygba.MainActivity',
      arguments: {
        'rom_uri': convertContentUriToFilePath(g.path),
      },
    );
  },
  'it.dbtecno.pizzaboygbapro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'it.dbtecno.pizzaboygbapro',
      componentName: 'it.dbtecno.pizzaboygbapro.MainActivity',
      arguments: {
        'rom_uri': convertContentUriToFilePath(g.path),
      },
    );
  },
  'com.explusalpha.GbaEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.explusalpha.GbaEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'com.fastemulator.gbafree': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.fastemulator.gbafree',
      componentName: 'com.fastemulator.gba.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.fastemulator.gba': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.fastemulator.gba',
      componentName: 'com.fastemulator.gba.EmulatorActivity',
      data: g.path,
    );
  },
  'com.explusalpha.A2600Emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.explusalpha.A2600Emu',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.androidemu.atari': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.androidemu.atari',
      componentName: 'com.androidemu.atari.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.androidemu.gg': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.androidemu.gg',
      componentName: 'com.androidemu.gg.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.fms.mg': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.fms.mg',
      componentName: 'com.fms.emulib.MainActivity',
      data: g.path,
    );
  },
  'io.recompiled.redream': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'io.recompiled.redream',
      componentName: 'io.recompiled.redream.MainActivity',
      data: g.path,
    );
  },
  'com.reicast.emulator': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.reicast.emulator',
      componentName: 'com.reicast.emulator.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.flycast.emulator': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'com.flycast.emulator',
      componentName: 'com.reicast.emulator.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.explusalpha.neoemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.explusalpha.neoemu',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.github.stenzek.duckstation': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.github.stenzek.duckstation',
      componentName: 'com.github.stenzek.duckstation.EmulationActivity',
      arguments: {
        'bootPath': g.path,
      },
    );
  },
  'com.emulator.fpse': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.emulator.fpse',
      componentName: 'com.emulator.fpse.Main',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.emulator.fpse64': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'com.emulator.fpse64',
      componentName: 'com.emulator.fpse64.Main',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'com.epsxe.ePSXe': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'acom.epsxe.ePSXe',
      componentName: 'com.epsxe.ePSXe.ePSXe',
      arguments: {
        'com.epsxe.ePSXe.isoName': convertContentUriToFilePath(g.path),
      },
    );
  },
};
