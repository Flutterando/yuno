import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gamepad_platform_interface.dart';

/// An implementation of [GamepadPlatform] that uses method channels.
class MethodChannelGamepad extends GamepadPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gamepad');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
