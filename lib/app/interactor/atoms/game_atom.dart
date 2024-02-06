import 'package:asp/asp.dart';
import 'package:collection/collection.dart';
import 'package:emu_icons/emu_icons.dart';
import 'package:localization/localization.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';
import 'package:yuno/app/interactor/models/embeds/game_category.dart';

import '../../core/assets/svgs.dart' as img;

// states
List<Game> get gamesState {
  return platformsState.value //
      .map((e) => e.games)
      .expand((games) => games)
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));
}

final gameSearchState = Atom<String>(
  '',
  pipe: debounceTime(const Duration(milliseconds: 500)),
);

final gamesCategoryState = Atom<GameCategory>(GameCategory.unknown());

List<Game> get filteredGamesState {
  var category = gamesCategoryState.value;
  if (!availableCategoriesState.contains(gamesCategoryState.value)) {
    if (availableCategoriesState.isNotEmpty) {
      category = availableCategoriesState.first;
    } else {
      category = GameCategory.unknown();
    }
    gamesCategoryState.setValueWithoutReaction(category);
  }

  if (category.id == 'all') {
    return gamesState;
  } else if (category.id == 'favorite') {
    return gamesState //
        .where((game) => game.isFavorite)
        .toList();
  } else {
    return platformsState.value
            .firstWhereOrNull(
              (e) => e.category == category,
            )
            ?.games ??
        [];
  }
}

List<GameCategory> get availableCategoriesState {
  return {
    if (gameConfigState.value.showAllTab)
      GameCategory(
        name: 'all'.i18n(),
        image: CategoryImage.fromSVG(img.allSVG),
        id: 'all',
      ),
    if (gameConfigState.value.showFavoriteTab)
      GameCategory(
        name: 'favorite'.i18n(),
        image: CategoryImage.fromSVG(img.favoriteSVG),
        id: 'favorite',
      ),
    ...platformsState.value //
        .map((platform) => platform.category)
        .toSet()
  }.toList(growable: false);
}

List<GameCategory> get categoriesFoSelectState {
  return [
    ...categorieState.where((e) => !availableCategoriesState.contains(e)),
  ];
}

final categorieState = [
  GameCategory(
    name: 'Android',
    image: CategoryImage.fromEmuIcon(BrandLogoName.android),
    id: 'android',
  ),
  GameCategory(
    name: 'Neo Geo',
    image: CategoryImage.fromSVG(img.neogeoSVG),
    id: 'neo-geo',
    extensions: ['zip', '7z'],
  ),
  GameCategory(
    name: 'Neo Geo CD',
    image: CategoryImage.fromSVG(img.neogeocdSVG),
    id: 'neo-geo-cd',
    extensions: ['chd', 'cue'],
  ),
  GameCategory(
    name: 'Neo Geo Pocket',
    image: CategoryImage.fromSVG(img.neogeopocketSVG),
    id: 'neo-geo-pocket',
    extensions: ['zip', 'ngp', 'ngc', '7z'],
  ),
  GameCategory(
    name: 'Neo Geo Pocket Color',
    image: CategoryImage.fromSVG(img.neogeopocketcolorSVG),
    id: 'neo-geo-pocket-color',
    extensions: ['zip', 'ngp', 'ngc', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - 3DS',
    image: CategoryImage.fromSVG(img.n3dsSVG),
    id: 'nintendo-3ds',
    extensions: ['3ds', '3dsx', 'app', 'axf', 'cci', 'cxi', 'elf'],
  ),
  GameCategory(
    name: 'Nintendo - 64',
    image: CategoryImage.fromEmuIcon(BrandLogoName.n64),
    id: 'nintendo-64',
    extensions: ['bin', 'n64', 'ndd', 'u1', 'v64', 'z64', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - DS',
    image: CategoryImage.fromSVG(img.ndsSVG),
    id: 'nintendo-ds',
    extensions: ['bin', 'nds', 'rar', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - Game Boy',
    shortName: 'Game Boy',
    image: CategoryImage.fromSVG(img.gameboySVG),
    id: 'nintendo-game-boy',
    extensions: ['gb', 'gbc', 'gbs', '7z', 'zip'],
  ),
  GameCategory(
    name: 'Nintendo - Game Boy Advance',
    image: CategoryImage.fromSVG(img.gameboyadvanceSVG),
    shortName: 'Game Boy Advance',
    id: 'nintendo-gba',
    extensions: ['bin', 'gba', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - Game Boy Color',
    image: CategoryImage.fromSVG(img.gameboycolorSVG),
    shortName: 'Game Boy Color',
    id: 'nintendo-gbc',
    extensions: ['gb', 'gbc', 'gbs', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - GameCube',
    image: CategoryImage.fromSVG(img.gamecubeSVG),
    shortName: 'GameCube',
    id: 'nintendo-gamecube',
    extensions: [
      'ciao',
      'ciso',
      'dff',
      'dol',
      'elf',
      'gcm',
      'gcz',
      'iso',
      'tgc',
      'wad',
      'wbfs',
      'rvz',
    ],
  ),
  GameCategory(
    name: 'Nintendo - Switch',
    shortName: 'Switch',
    image: CategoryImage.fromEmuIcon(BrandLogoName.switchLogo),
    id: 'switch',
    extensions: ['nro', 'nso', 'nca', 'xci', 'nsp'],
  ),
  GameCategory(
    name: 'Nintendo - Wii',
    shortName: 'Wii',
    image: CategoryImage.fromSVG(img.wiiSVG),
    id: 'nintendo-wii',
    extensions: [
      'ciao',
      'dff',
      'dol',
      'elf',
      'gcm',
      'gcz',
      'iso',
      'tgc',
      'wad',
      'wbfs',
      'rvz',
    ],
  ),
  GameCategory(
    name: 'Nintendo Entertainment System',
    shortName: 'NES',
    image: CategoryImage.fromSVG(img.nesSVG),
    id: 'nes',
    extensions: [
      'bin',
      'fds',
      'nes',
      'nsf',
      'qd',
      'rom',
      'unf',
      'unif',
      'zip',
      '7z'
    ],
  ),
  GameCategory(
    name: 'Sega 32X',
    image: CategoryImage.fromSVG(img.sega32xSVG),
    id: 'sega-32x',
    extensions: [
      '32x',
      '68k',
      'bin',
      'chd',
      'cue',
      'gen',
      'gg',
      'iso',
      'm3u',
      'md',
      'pco',
      'sgd',
      'smd',
      'sms',
      '7z',
      'zip',
    ],
  ),
  GameCategory(
    name: 'Sega CD',
    image: CategoryImage.fromSVG(img.segacdSVG),
    id: 'sega-cd',
    extensions: [
      '32x',
      '68k',
      'bin',
      'bms',
      'chd',
      'cue',
      'gen',
      'gg',
      'iso',
      'm3u',
      'md',
      'mdx',
      'pco',
      'sg',
      'sgd',
      'smd',
      'sms'
    ],
  ),
  GameCategory(
    name: 'Sega Dreamcast',
    image: CategoryImage.fromSVG(img.dreamcastSVG),
    id: 'sega-dreamcast',
    extensions: ['cdi', 'chd', 'gdi', 'bin', 'dat', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Sega Game Gear',
    image: CategoryImage.fromSVG(img.segagamegearSVG),
    id: 'sega-game-gear',
    extensions: ['bin', 'bms', 'col', 'gg', 'rom', 'sg', 'sms', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Sega Genesis',
    image: CategoryImage.fromSVG(img.segagenesisSVG),
    id: 'sega-genesis',
    extensions: [
      '32x',
      '68k',
      'bin',
      'bms',
      'chd',
      'cue',
      'gen',
      'gg',
      'iso',
      'm3u',
      'md',
      'mdx',
      'pco',
      'sg',
      'sgd',
      'smd',
      'sms',
      '7z',
      'zip'
    ],
  ),
  GameCategory(
    name: 'Sega Master System',
    image: CategoryImage.fromSVG(img.segamastersystemSVG),
    id: 'sega-master-system',
    extensions: [
      '32x',
      '68k',
      'bin',
      'bms',
      'chd',
      'cue',
      'gen',
      'gg',
      'iso',
      'm3u',
      'md',
      'mdx',
      'pco',
      'sg',
      'sgd',
      'smd',
      'sms',
      '7z',
      'zip'
    ],
  ),
  GameCategory(
    name: 'Sega Saturn',
    image: CategoryImage.fromSVG(img.segasaturnSVG),
    id: 'sega-saturn',
    extensions: [
      'bin',
      'ccd',
      'chd',
      'cue',
      'iso',
      'm3u',
      'mds',
      'toc',
      'zip',
      '7z'
    ],
  ),
  GameCategory(
    name: 'Sony - PlayStation',
    image: CategoryImage.fromSVG(img.ps1SVG),
    id: 'ps1',
    extensions: [
      'bin',
      'chd',
      'cue',
      'ecm',
      'exe',
      'img',
      'iso',
      'm3u',
      'mds',
      'pbp',
      'psexe',
      'psf',
    ],
  ),
  GameCategory(
    name: 'Sony - PlayStation 2',
    image: CategoryImage.fromEmuIcon(BrandLogoName.ps2),
    id: 'ps2',
    extensions: ['bin', 'chd', 'cso', 'cue', 'gz', 'iso'],
  ),
  GameCategory(
    name: 'Sony - PlayStation Portable',
    image: CategoryImage.fromSVG(img.pspSVG),
    id: 'psp',
    extensions: ['cso', 'chd', 'elf', 'iso', 'pbp', 'prx'],
  ),
  GameCategory(
    name: 'Sony - PlayStation Vita',
    image: CategoryImage.fromSVG(img.psvitaSVG),
    id: 'psvita',
    extensions: ['dpt'],
  ),
  GameCategory(
    name: 'Super Nintendo Entertainment System',
    shortName: 'SNES',
    image: CategoryImage.fromSVG(img.snesSVG),
    id: 'snes',
    extensions: [
      'bml',
      'bs',
      'bsx',
      'dx2',
      'fig',
      'gb',
      'gbc',
      'gd3',
      'gd7',
      'rom',
      'sfc',
      'smc',
      'st',
      'swc',
      'zip',
      '7z'
    ],
  ),
  GameCategory(
    name: 'TurboGrafx 16',
    image: CategoryImage.fromSVG(img.turbografx16SVG),
    id: 'turbografx-16',
    extensions: ['ccd', 'chd', 'cue', 'm3u', 'pce', 'sgx', 'toc', 'zip', '7z'],
  ),
  GameCategory(
    name: 'TurboGrafx CD',
    image: CategoryImage.fromSVG(img.turbografxcdSVG),
    id: 'turbografx-cd',
    extensions: ['ccd', 'chd', 'cue', 'm3u', 'pce', 'sgx', 'toc'],
  ),
];
