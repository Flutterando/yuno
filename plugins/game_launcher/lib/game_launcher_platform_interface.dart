import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'game_launcher_method_channel.dart';

abstract class GameLauncherPlatform extends PlatformInterface {
  /// Constructs a GameLauncherPlatform.
  GameLauncherPlatform() : super(token: _token);

  static final Object _token = Object();

  static GameLauncherPlatform _instance = MethodChannelGameLauncher();

  /// The default instance of [GameLauncherPlatform] to use.
  ///
  /// Defaults to [MethodChannelGameLauncher].
  static GameLauncherPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GameLauncherPlatform] when
  /// they register themselves.
  static set instance(GameLauncherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
