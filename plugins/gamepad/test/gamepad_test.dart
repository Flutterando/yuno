import 'package:flutter_test/flutter_test.dart';
import 'package:gamepad/gamepad.dart';
import 'package:gamepad/gamepad_platform_interface.dart';
import 'package:gamepad/gamepad_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGamepadPlatform
    with MockPlatformInterfaceMixin
    implements GamepadPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GamepadPlatform initialPlatform = GamepadPlatform.instance;

  test('$MethodChannelGamepad is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGamepad>());
  });

  test('getPlatformVersion', () async {
    Gamepad gamepadPlugin = Gamepad();
    MockGamepadPlatform fakePlatform = MockGamepadPlatform();
    GamepadPlatform.instance = fakePlatform;

    expect(await gamepadPlugin.getPlatformVersion(), '42');
  });
}
