import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'game_launcher_platform_interface.dart';

/// An implementation of [GameLauncherPlatform] that uses method channels.
class MethodChannelGameLauncher extends GameLauncherPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('game_launcher');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
