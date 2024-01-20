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
      .toList()..sort((a, b) => a.name.compareTo(b.name));
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

final categorieState = <GameCategory>[
  GameCategory(name: 'Android', image: img.androidSVG, id: 'android'),
  GameCategory(
    name: 'Nintendo Switch',
    image: img.switchSVG,
    id: 'switch',
    extensions: ['nsp', 'xci'],
  ),
  GameCategory(
    name: 'Super Nintendo',
    image: img.switchSVG,
    id: 'snes',
    extensions: ['smc', 'sfc', 'zip'],
  ),
  GameCategory(
    name: 'Playstation 1',
    image: img.ps1SVG,
    id: 'ps1',
    extensions: ['bin', 'cue', 'iso'],
  ),
  GameCategory(
    name: 'Playstation 2',
    image: img.ps2SVG,
    id: 'ps2',
    extensions: ['bin', 'cue', 'iso'],
  ),
  GameCategory(
    name: 'Playstation Portable',
    image: img.pspSVG,
    id: 'psp',
    extensions: ['cso', 'iso'],
  ),
];
