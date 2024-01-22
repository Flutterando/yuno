import 'package:yuno/app/interactor/models/embeds/player.dart';

import '../models/embeds/game.dart';
import 'platform_action.dart';

typedef IntentFunction = PlayerIntent Function(Player, Game);

PlayerIntent? getAppIntent(Game game, Player player) {
  return _defaultAppIntent[player.app.package]?.call(player, game);
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
  'psp.org.ppsspp.ppsspp': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'psp.org.ppsspp.ppsspp',
      type: 'application/octet-stream',
      category: 'android.intent.category.DEFAULT',
      componentName: '.PpssppActivity',
      data: g.path,
    );
  },
  'psp.org.ppsspp.ppssppgold': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'psp.org.ppsspp.ppssppgold',
      type: 'application/octet-stream',
      category: 'android.intent.category.DEFAULT',
      componentName: 'org.ppsspp.ppsspp.PpssppActivity',
      data: g.path,
    );
  },
  'snesmsu1.com.explusalpha.Snes9xPlus': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'snesmsu1.com.explusalpha.Snes9xPlus',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'ngpc.com.explusalpha.NgpEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'ngpc.com.explusalpha.NgpEmu',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
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
  'ps2.xyz.aethersx2.android': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'ps2.xyz.aethersx2.android',
      componentName: '.EmulationActivity',
      arguments: {'bootPath': g.path},
    );
  },
  'ps2.xyz.aethersx2.custom': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'ps2.xyz.aethersx2.custom',
      componentName: '.EmulationActivity',
      arguments: {'bootPath': g.path},
    );
  },
  'cps2.com.explusalpha.neoemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'cps2.com.explusalpha.neoemu',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'cps3.com.explusalpha.neoemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'cps3.com.explusalpha.neoemu',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'ngp.com.explusalpha.NgpEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'ngp.com.explusalpha.NgpEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  '3ds.org.citra.nightly': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: '3ds.org.citra.nightly',
      componentName: 'org.citra.citra_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  '3ds.org.citra.canary': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: '3ds.org.citra.canary',
      componentName: 'org.citra.citra_emu.activities.EmulationActivity',
      data: g.path,
    );
  },
  '3ds.com.antutu.ABenchMark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: '3ds.com.antutu.ABenchMark',
      componentName: 'org.citra.emu.ui.EmulationActivity',
      arguments: {'GamePath': g.path},
    );
  },
  '3ds.com.antutu.SAABenchMark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: '3ds.com.antutu.SAABenchMark',
      componentName: 'org.citra.emu.ui.EmulationActivity',
      arguments: {'GamePath': g.path},
    );
  },
  '3ds.org.citra.emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: '3ds.org.citra.emu',
      componentName: 'org.citra.emu.ui.EmulationActivity',
      arguments: {'GamePath': g.path},
    );
  },
  '3ds.org.citra.citra_emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: '3ds.org.citra.citra_emu',
      componentName: 'org.citra.citra_emu.ui.EmulationActivity',
      arguments: {'GamePath': g.path},
    );
  },
  'genesis.com.explusalpha.MdEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'genesis.com.explusalpha.MdEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'segacd.com.explusalpha.MdEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'segacd.com.explusalpha.MdEmu',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'master.com.explusalpha.MdEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'master.com.explusalpha.MdEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'switch.skyline.emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'switch.skyline.emu',
      componentName: 'emu.skyline.EmulationActivity',
      data: g.path,
    );
  },
  'switch.strato.yosho': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'switch.strato.yosho',
      componentName: 'emu.skyline.EmulationActivity',
      data: g.path,
    );
  },
  'wii.org.dolphinemu.handheld': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wii.org.dolphinemu.handheld',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wii.org.mm.jr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wii.org.mm.jr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': convertContentUriToFilePath(g.path),
      },
    );
  },
  'wii.org.mm.j': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wii.org.mm.j',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': convertContentUriToFilePath(g.path),
      },
    );
  },
  'wii.org.dolphinemu.mmjr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wii.org.dolphinemu.mmjr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wii.org.dolphinemu.dolphinemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'wii.org.dolphinemu.dolphinemu',
      componentName: '.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wii.org.dolphinemu.mmjr3': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wii.org.dolphinemu.mmjr3',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wii.org.dolphin.ishiirukadark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wii.org.dolphin.ishiirukadark',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'satellaview.com.explusalpha.Snes9xPlus': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'satellaview.com.explusalpha.Snes9xPlus',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'nds.com.dsemu.drastic': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'nds.com.dsemu.drastic',
      componentName: '.DraSticActivity',
    );
  },
  'nds.me.magnum.melonds': (p, g) {
    return PlayerIntent(
      action: 'me.magnum.melonds.LAUNCH_ROM',
      package: 'nds.me.magnum.melonds',
      arguments: {'uri': g.path},
    );
  },
  'nds.com.hydra.noods.FileBrowser': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'nds.com.hydra.noods.FileBrowser',
      componentName: '.FileBrowser',
      arguments: {
        'LaunchPath': convertContentUriToFilePath(g.path),
      },
    );
  },
  'fds.com.explusalpha.NesEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'fds.com.explusalpha.NesEmu',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'fds.com.androidemu.nes': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'fds.com.androidemu.nes',
      componentName: '.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'tgcd.com.explusalpha.PceEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'tgcd.com.explusalpha.PceEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'tg16.com.explusalpha.PceEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'tg16.com.explusalpha.PceEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'n64.org.mupen64plusae.v3.fzurita': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'n64.org.mupen64plusae.v3.fzurita',
      componentName: 'paulscode.android.mupen64plusae.SplashActivity',
      data: g.path,
    );
  },
  'n64.org.mupen64plusae.v3.alpha': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'n64.org.mupen64plusae.v3.alpha',
      componentName: 'paulscode.android.mupen64plusae.SplashActivity',
      data: g.path,
    );
  },
  'n64.org.mupen64plusae.v3.fzurita.pro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'n64.org.mupen64plusae.v3.fzurita.pro',
      componentName: 'paulscode.android.mupen64plusae.SplashActivity',
      data: g.path,
    );
  },
  'n64.paulscode.android.mupen64plusae': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'n64.paulscode.android.mupen64plusae',
      componentName: '.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'gbc.it.dbtecno.pizzaboy': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'gbc.it.dbtecno.pizzaboy',
      componentName: 'it.dbtecno.pizzaboy.MainActivity',
      arguments: {'rom_uri': convertContentUriToFilePath(g.path)},
    );
  },
  'gbc.it.dbtecno.pizzaboypro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'gbc.it.dbtecno.pizzaboypro',
      componentName: 'it.dbtecno.pizzaboypro.MainActivity',
      arguments: {'rom_uri': convertContentUriToFilePath(g.path)},
    );
  },
  'gbc.com.sky.SkyEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gbc.com.sky.SkyEmu',
      componentName: '.EnhancedNativeActivity',
      data: g.path,
    );
  },
  'gbc.com.explusalpha.GbcEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gbc.com.explusalpha.GbcEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'gbc.com.fastemulator.gbcfree': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gbc.com.fastemulator.gbcfree',
      componentName: '.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'gbc.com.fastemulator.gbc': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gbc.com.fastemulator.gbc',
      componentName: '.EmulatorActivity',
      data: g.path,
    );
  },
  'naomi.com.flycast.emulator': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'naomi.com.flycast.emulator',
      componentName: 'com.reicast.emulator.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'wiiware.org.dolphinemu.handheld': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wiiware.org.dolphinemu.handheld',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wiiware.org.mm.jr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wiiware.org.mm.jr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wiiware.org.mm.j': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wiiware.org.mm.j',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wiiware.org.dolphinemu.mmjr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wiiware.org.dolphinemu.mmjr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wiiware.org.dolphinemu.dolphinemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'wiiware.org.dolphinemu.dolphinemu',
      componentName: '.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wiiware.org.dolphinemu.mmjr3': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wiiware.org.dolphinemu.mmjr3',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'wiiware.org.dolphin.ishiirukadark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'wiiware.org.dolphin.ishiirukadark',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'gb.it.dbtecno.pizzaboy': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'gb.it.dbtecno.pizzaboy',
      componentName: 'it.dbtecno.pizzaboy.MainActivity',
      arguments: {
        'rom_uri': convertContentUriToFilePath(g.path),
      },
    );
  },
  'gb.it.dbtecno.pizzaboypro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'gb.it.dbtecno.pizzaboypro',
      componentName: 'it.dbtecno.pizzaboypro.MainActivity',
      arguments: {
        'rom_uri': convertContentUriToFilePath(g.path),
      },
    );
  },
  'gb.com.sky.SkyEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gb.com.sky.SkyEmu',
      componentName: '.EnhancedNativeActivity',
      data: g.path,
    );
  },
  'gb.com.explusalpha.GbcEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gb.com.explusalpha.GbcEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'gb.com.fastemulator.gbcfree': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gb.com.fastemulator.gbcfree',
      componentName: '.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'gb.com.fastemulator.gbc': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gb.com.fastemulator.gbc',
      componentName: '.EmulatorActivity',
      data: g.path,
    );
  },
  'neogeo.com.explusalpha.NeoEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'neogeo.com.explusalpha.NeoEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'snes.com.explusalpha.Snes9xPlus': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'snes.com.explusalpha.Snes9xPlus',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'pspminis.org.ppsspp.ppsspp': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'pspminis.org.ppsspp.ppsspp',
      type: 'application/octet-stream',
      category: 'android.intent.category.DEFAULT',
      componentName: '.PpssppActivity',
      data: g.path,
    );
  },
  'pspminis.org.ppsspp.ppssppgold': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'pspminis.org.ppsspp.ppssppgold',
      type: 'application/octet-stream',
      category: 'android.intent.category.DEFAULT',
      componentName: 'org.ppsspp.ppsspp.PpssppActivity',
      data: g.path,
    );
  },
  'gc.org.dolphinemu.handheld': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gc.org.dolphinemu.handheld',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'gc.org.mm.jr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gc.org.mm.jr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'gc.org.mm.j': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gc.org.mm.j',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'gc.org.dolphinemu.mmjr': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gc.org.dolphinemu.mmjr',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'gc.org.dolphinemu.dolphinemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'gc.org.dolphinemu.dolphinemu',
      componentName: '.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'gc.org.dolphinemu.mmjr3': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gc.org.dolphinemu.mmjr3',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'gc.org.dolphin.ishiirukadark': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gc.org.dolphin.ishiirukadark',
      componentName: 'org.dolphinemu.dolphinemu.ui.main.MainActivity',
      arguments: {
        'AutoStartFile': g.path,
      },
    );
  },
  'saturn.org.devmiyax.yabasanshioro2.pro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'saturn.org.devmiyax.yabasanshioro2.pro',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'saturn.org.devmiyax.yabasanshioro2': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'saturn.org.devmiyax.yabasanshioro2',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'saturn.org.uoyabause.android.pro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'saturn.org.uoyabause.android.pro',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'saturn.org.uoyabause.android': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'saturn.org.uoyabause.android',
      componentName: 'org.uoyabause.android.Yabause',
      arguments: {
        'org.uoyabause.android.FileNameEx': convertContentUriToFilePath(g.path),
      },
    );
  },
  'gba.it.dbtecno.pizzaboygba': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'gba.it.dbtecno.pizzaboygba',
      componentName: 'it.dbtecno.pizzaboygba.MainActivity',
      arguments: {
        'rom_uri': convertContentUriToFilePath(g.path),
      },
    );
  },
  'gba.it.dbtecno.pizzaboygbapro': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'gba.it.dbtecno.pizzaboygbapro',
      componentName: 'it.dbtecno.pizzaboygbapro.MainActivity',
      arguments: {
        'rom_uri': convertContentUriToFilePath(g.path),
      },
    );
  },
  'gba.com.sky.SkyEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gba.com.sky.SkyEmu',
      componentName: '.EnhancedNativeActivity',
      data: g.path,
    );
  },
  'gba.com.explusalpha.GbaEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gba.com.explusalpha.GbaEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'gba.com.fastemulator.gbafree': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gba.com.fastemulator.gbafree',
      componentName: 'com.fastemulator.gba.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'gba.com.fastemulator.gba': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gba.com.fastemulator.gba',
      componentName: '.EmulatorActivity',
      data: g.path,
    );
  },
  'supergrafx.com.explusalpha.PceEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'supergrafx.com.explusalpha.PceEmu',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'atari2600.com.explusalpha.A2600Emu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'atari2600.com.explusalpha.A2600Emu',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'atari2600.com.androidemu.atari': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'atari2600.com.androidemu.atari',
      componentName: '.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'j2me.ru.playsoftware.j2meloader': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'j2me.ru.playsoftware.j2meloader',
      componentName: 'ru.playsoftware.j2meloader.MainActivity',
      data: g.path,
    );
  },
  'gamegear.com.androidemu.gg': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gamegear.com.androidemu.gg',
      componentName: '.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'gamegear.com.fms.mg': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'gamegear.com.fms.mg',
      componentName: 'com.fms.emulib.MainActivity',
      data: g.path,
    );
  },
  'atomiswave.io.recompiled.redream': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'atomiswave.io.recompiled.redream',
      componentName: '.MainActivity',
      data: g.path,
    );
  },
  'atomiswave.com.reicast.emulator': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'atomiswave.com.reicast.emulator',
      componentName: '.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'atomiswave.com.flycast.emulator': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'atomiswave.com.flycast.emulator',
      componentName: 'com.reicast.emulator.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'jaguar.ru.vastness.altmer.iratajaguar': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'jaguar.ru.vastness.altmer.iratajaguar',
      componentName: 'ru.vastness.altmer.iratajaguar.MainActivity',
      arguments: {
        'rom': convertContentUriToFilePath(g.path),
      },
    );
  },
  'cps1.com.explusalpha.neoemu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'cps1.com.explusalpha.neoemu',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'dreamcast.io.recompiled.redream': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'dreamcast.io.recompiled.redream',
      componentName: '.MainActivity',
      data: g.path,
    );
  },
  'dreamcast.com.reicast.emulator': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'dreamcast.com.reicast.emulator',
      componentName: '.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'dreamcast.com.flycast.emulator': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'dreamcast.com.flycast.emulator',
      componentName: 'com.reicast.emulator.MainActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'msx.com.explusalpha.MsxEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'msx.com.explusalpha.MsxEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'nes.com.explusalpha.NesEmu': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'nes.com.explusalpha.NesEmu',
      type: 'application/zip',
      componentName: 'com.imagine.BaseActivity',
      data: g.path,
    );
  },
  'nes.com.androidemu.nes': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.VIEW',
      package: 'nes.com.androidemu.nes',
      componentName: '.EmulatorActivity',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'psx.com.github.stenzek.duckstation': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'psx.com.github.stenzek.duckstation',
      componentName: '.EmulationActivity',
      arguments: {
        'bootPath': g.path,
      },
    );
  },
  'psx.com.emulator.fpse': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'psx.com.emulator.fpse',
      componentName: '.Main',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'psx.com.emulator.fpse64': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'psx.com.emulator.fpse64',
      componentName: '.Main',
      data: convertContentUriToFilePath(g.path),
    );
  },
  'psx.com.epsxe.ePSXe': (p, g) {
    return PlayerIntent(
      action: 'android.intent.action.MAIN',
      package: 'psx.com.epsxe.ePSXe',
      componentName: '.ePSXe',
      arguments: {
        'com.epsxe.ePSXe.isoName': convertContentUriToFilePath(g.path),
      },
    );
  },
};
