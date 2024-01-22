import 'package:yuno/app/interactor/models/embeds/game.dart';

abstract class SyncRepository {
  Future<Game> syncIGDB(Game game);
  Future<Game> syncRAWG(Game game);
}