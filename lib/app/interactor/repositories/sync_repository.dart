import 'package:yuno/app/interactor/models/embeds/game.dart';

abstract class SyncRepository {
  Future<Game> syncIGDB(Game game);
  Future<Game> syncLocalFolder(Game game, String coverFolder);
  Future<Game> syncRAWG(Game game);
}
