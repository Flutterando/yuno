import 'package:asp/asp.dart';
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

final gamesCategoryState = Atom<GameCategory>(defaultCategoryAllState);

List<Game> get filteredGamesState {
  if (gamesCategoryState.value.id == 'all') {
    return gamesState;
  } else if (gamesCategoryState.value.id == 'favorite') {
    return gamesState //
        .where((game) => game.isFavorite)
        .toList();
  } else {
    return platformsState.value
        .firstWhere(
          (e) => e.category == gamesCategoryState.value,
        )
        .games;
  }
}

List<GameCategory> get availableCategoriesState {
  return {
    defaultCategoryAllState,
    defaultCategoryFavorite,
    ...platformsState.value //
        .map((platform) => platform.category)
        .toSet()
  }.toList(growable: false);
}

final defaultCategoryAllState =
    GameCategory(name: 'All', image: img.allSVG, id: 'all');
final defaultCategoryFavorite =
    GameCategory(name: 'Favorite', image: img.favoriteSVG, id: 'favorite');

List<GameCategory> get categoriesFoSelectState {
  return [
    ...categorieState.where((e) => !availableCategoriesState.contains(e)),
  ];
}

final categorieState = [
  GameCategory(name: 'Android', image: img.androidSVG, id: 'android'),
  GameCategory(
    name: 'Neo Geo',
    image: img.neogeoSVG,
    id: 'neo-geo',
    extensions: ['zip', '7z'],
  ),
  GameCategory(
    name: 'Neo Geo CD',
    image: img.neogeocdSVG,
    id: 'neo-geo-cd',
    extensions: ['chd', 'cue'],
  ),
  GameCategory(
    name: 'Neo Geo Pocket',
    image: img.neogeopocketSVG,
    id: 'neo-geo-pocket',
    extensions: ['zip', 'ngp', 'ngc', '7z'],
  ),
  GameCategory(
    name: 'Neo Geo Pocket Color',
    image: img.neogeopocketcolorSVG,
    id: 'neo-geo-pocket-color',
    extensions: ['zip', 'ngp', 'ngc', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - 3DS',
    image: img.n3dsSVG,
    id: 'nintendo-3ds',
    extensions: ['3ds', '3dsx', 'app', 'axf', 'cci', 'cxi', 'elf'],
  ),
  GameCategory(
    name: 'Nintendo - 64',
    image: img.n64SVG,
    id: 'nintendo-64',
    extensions: ['bin', 'n64', 'ndd', 'u1', 'v64', 'z64', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - DS',
    image: img.ndsSVG,
    id: 'nintendo-ds',
    extensions: ['bin', 'nds', 'rar', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - Game Boy',
    shortName: 'Game Boy',
    image: img.gameboySVG,
    id: 'nintendo-game-boy',
    extensions: ['gb', 'gbc', 'gbs'],
  ),
  GameCategory(
    name: 'Nintendo - Game Boy Advance',
    image: img.gameboyadvanceSVG,
    shortName: 'Game Boy Advance',
    id: 'nintendo-gba',
    extensions: ['bin', 'gba', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - Game Boy Color',
    image: img.gameboycolorSVG,
    shortName: 'Game Boy Color',
    id: 'nintendo-gbc',
    extensions: ['gb', 'gbc', 'gbs', 'zip', '7z'],
  ),
  GameCategory(
    name: 'Nintendo - GameCube',
    image: img.gamecubeSVG,
    shortName: 'GameCube',
    id: 'nintendo-gamecube',
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
    name: 'Nintendo - Switch',
    shortName: 'Switch',
    image: img.switchSVG,
    id: 'switch',
    extensions: ['nro', 'nso', 'nca', 'xci', 'nsp'],
  ),
  GameCategory(
    name: 'Nintendo - Wii',
    shortName: 'Wii',
    image: img.wiiSVG,
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
    image: img.nesSVG,
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
    image: img.sega32xSVG,
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
    image: img.segacdSVG,
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
    image: img.dreamcastSVG,
    id: 'sega-dreamcast',
    extensions: ['cdi', 'gdi'],
  ),
  GameCategory(
    name: 'Sega Game Gear',
    image: img.segagamegearSVG,
    id: 'sega-game-gear',
    extensions: ['bin', 'bms', 'col', 'gg', 'rom', 'sg', 'sms'],
  ),
  GameCategory(
    name: 'Sega Genesis',
    image: img.segagenesisSVG,
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
    ],
  ),
  GameCategory(
    name: 'Sega Master System',
    image: img.segamastersystemSVG,
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
    ],
  ),
  GameCategory(
    name: 'Sega Saturn',
    image: img.segasaturnSVG,
    id: 'sega-saturn',
    extensions: ['bin', 'ccd', 'chd', 'cue', 'iso', 'm3u', 'mds', 'toc', 'zip'],
  ),
  GameCategory(
    name: 'Sony - PlayStation',
    image: img.ps1SVG,
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
    image: img.ps2SVG,
    id: 'ps2',
    extensions: ['bin', 'cue', 'iso', 'chd'],
  ),
  GameCategory(
    name: 'Sony - PlayStation Portable',
    image: img.pspSVG,
    id: 'psp',
    extensions: ['cso', 'chd', 'elf', 'iso', 'pbp', 'prx'],
  ),
  GameCategory(
    name: 'Sony - PlayStation Vita',
    image: img.psvitaSVG,
    id: 'psvita',
    extensions: ['dpt'],
  ),
  GameCategory(
    name: 'Super Nintendo Entertainment System',
    shortName: 'SNES',
    image: img.snesSVG,
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
    ],
  ),
  GameCategory(
    name: 'TurboGrafx 16',
    image: img.turbografx16SVG,
    id: 'turbografx-16',
    extensions: ['ccd', 'chd', 'cue', 'm3u', 'pce', 'sgx', 'toc', 'zip', '7z'],
  ),
  GameCategory(
    name: 'TurboGrafx CD',
    image: img.turbografxcdSVG,
    id: 'turbografx-cd',
    extensions: ['ccd', 'chd', 'cue', 'm3u', 'pce', 'sgx', 'toc'],
  ),
];
