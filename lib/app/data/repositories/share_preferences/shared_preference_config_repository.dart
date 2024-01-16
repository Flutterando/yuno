import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuno/app/interactor/models/game_config.dart';
import 'package:yuno/app/interactor/repositories/config_repository.dart';

class SharedPreferenceConfigRepository implements ConfigRepository {
  static const _key = 'config';

  @override
  Future<GameConfig> getConfig() async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key);
    if (json == null) {
      return GameConfig();
    } else {
      return GameConfig.fromJson(json);
    }
  }

  @override
  Future<void> saveConfig(GameConfig config) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString(_key, config.toJson());
  }

  @override
  Future<void> openUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception("Cold't launch");
    }
  }
}
