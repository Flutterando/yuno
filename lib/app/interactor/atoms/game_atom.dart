import 'package:asp/asp.dart';
import 'package:yuno/app/interactor/models/game.dart';
import 'package:yuno/app/interactor/models/game_category.dart';

import '../../core/assets/static.dart' as img;

// states
final gamesState = Atom<List<Game>>([]);

final gamesCategoryState = Atom<GameCategory>(defaultCategoryAllState);

List<Game> get gamesByCategoryState {
  return gamesState.value //
      .where((game) => game.category.contains(gamesCategoryState.value))
      .toList();
}

List<GameCategory> get availableCategoriesState {
  return {
    defaultCategoryAllState,
    defaultCategoryFavorite,
    ...gamesState.value //
        .map((game) => game.category)
        .expand((category) => category)
        .toSet()
  }.toList(growable: false);
}

final defaultCategoryAllState = GameCategory(name: 'All', image: img.allPNG);
final defaultCategoryFavorite = GameCategory(name: 'Favorite', image: img.favoritePNG);

final categorieState = <GameCategory>[
  GameCategory(name: 'Android', image: img.androidPNG),
  GameCategory(name: 'Nintendo Switch', image: img.switchPNG),
];
