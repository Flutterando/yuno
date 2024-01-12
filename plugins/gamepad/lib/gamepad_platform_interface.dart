import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gamepad_method_channel.dart';

abstract class GamepadPlatform extends PlatformInterface {
  /// Constructs a GamepadPlatform.
  GamepadPlatform() : super(token: _token);

  static final Object _token = Object();

  static GamepadPlatform _instance = MethodChannelGamepad();

  /// The default instance of [GamepadPlatform] to use.
  ///
  /// Defaults to [MethodChannelGamepad].
  static GamepadPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GamepadPlatform] when
  /// they register themselves.
  static set instance(GamepadPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
