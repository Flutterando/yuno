
import 'game_launcher_platform_interface.dart';

class GameLauncher {
  Future<String?> getPlatformVersion() {
    return GameLauncherPlatform.instance.getPlatformVersion();
  }
}
