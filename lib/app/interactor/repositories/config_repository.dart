import 'package:yuno/app/interactor/models/game_config.dart';

abstract class ConfigRepository {
  Future<GameConfig> getConfig();
  Future<void> saveConfig(GameConfig config);
  Future<void> openUrl(Uri uri);
}
