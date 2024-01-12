
import 'gamepad_platform_interface.dart';

class Gamepad {
  Future<String?> getPlatformVersion() {
    return GamepadPlatform.instance.getPlatformVersion();
  }
}
