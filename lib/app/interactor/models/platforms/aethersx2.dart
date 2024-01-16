import '../../repositories/apps_repository.dart';
import '../game.dart';
import '../game_platform.dart';

class AetherSX2 extends GamePlatform {
  AetherSX2()
      : super(
          idApp: 'xyz.aethersx2.android',
          name: 'PlayStation 2',
        );

  @override
  Future<void> execute(Game game, AppsRepository appsRepository) {
    return appsRepository.openWithCustomConfig(
      action: 'android.intent.action.MAIN',
      package: idApp,
      componentName: 'xyz.aethersx2.android.EmulationActivity',
      arguments: {
        'bootPath': game.path,
      },
    );
  }
}
