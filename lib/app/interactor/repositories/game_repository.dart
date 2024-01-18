import '../models/embeds/game.dart';

abstract class GameRepository {
  Future<List<Game>> getGames();
}
