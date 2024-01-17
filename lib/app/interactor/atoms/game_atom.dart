import 'package:asp/asp.dart';
import 'package:yuno/app/interactor/models/game.dart';
import 'package:yuno/app/interactor/models/game_category.dart';

import '../../core/assets/svgs.dart' as img;

// states
final gamesState = Atom<List<Game>>([]);

final gameSearchState = Atom<String>(
  '',
  pipe: debounceTime(const Duration(milliseconds: 500)),
);

final gamesCategoryState = Atom<GameCategory>(defaultCategoryAllState);

List<Game> get filteredGamesState {
  if (gameSearchState.value.isEmpty) {
    return gamesState.value //
        .where((game) => game.categories.contains(gamesCategoryState.value))
        .toList();
  } else {
    return gamesState.value //
        .where((game) => game.name
            .toLowerCase()
            .contains(gameSearchState.value.toLowerCase()))
        .where((game) => game.categories.contains(gamesCategoryState.value))
        .toList();
  }
}

List<GameCategory> get availableCategoriesState {
  return {
    defaultCategoryAllState,
    defaultCategoryFavorite,
    ...gamesState.value //
        .map((game) => game.categories)
        .expand((categories) => categories)
        .toSet()
  }.toList(growable: false);
}

final defaultCategoryAllState =
    GameCategory(name: 'All', image: img.allSVG, id: 'all');
final defaultCategoryFavorite =
    GameCategory(name: 'Favorite', image: img.favoriteSVG, id: 'favorite');

final categorieState = <GameCategory>[
  GameCategory(name: 'Android', image: img.androidSVG, id: 'android'),
  GameCategory(name: 'Nintendo Switch', image: img.switchSVG, id: 'switch'),
  GameCategory(name: 'Playstation 1', image: img.ps1SVG, id: 'ps1'),
  GameCategory(name: 'Playstation 2', image: img.ps2SVG, id: 'ps2'),
  GameCategory(name: 'Playstation Portable', image: img.pspSVG, id: 'psp'),
];
