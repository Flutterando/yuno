import 'package:flutter_test/flutter_test.dart';
import 'package:game_launcher/game_launcher.dart';
import 'package:game_launcher/game_launcher_platform_interface.dart';
import 'package:game_launcher/game_launcher_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGameLauncherPlatform
    with MockPlatformInterfaceMixin
    implements GameLauncherPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GameLauncherPlatform initialPlatform = GameLauncherPlatform.instance;

  test('$MethodChannelGameLauncher is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGameLauncher>());
  });

  test('getPlatformVersion', () async {
    GameLauncher gameLauncherPlugin = GameLauncher();
    MockGameLauncherPlatform fakePlatform = MockGameLauncherPlatform();
    GameLauncherPlatform.instance = fakePlatform;

    expect(await gameLauncherPlugin.getPlatformVersion(), '42');
  });
}
