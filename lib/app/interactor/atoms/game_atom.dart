import 'package:asp/asp.dart';
import 'package:yuno/app/interactor/models/game.dart';
import 'package:yuno/app/interactor/models/game_category.dart';

// states
final gamesState = Atom<List<Game>>([]);

final gamesCategoryState = Atom<GameCategory?>(null);

List<Game> get gamesByCategory {
  if (gamesCategoryState.value == null) {
    return gamesState.value;
  }

  return gamesState.value //
      .where((game) => game.category == gamesCategoryState.value)
      .toList();
}
