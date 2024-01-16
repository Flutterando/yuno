import '../../repositories/apps_repository.dart';
import '../game.dart';
import '../game_platform.dart';

class Retroarch extends GamePlatform {
  final String libretro;

  Retroarch(this.libretro)
      : super(
          idApp: 'com.retroarch.aarch64',
          name: 'Retroarch',
        );

  @override
  Future<void> execute(Game game, AppsRepository appsRepository) {
    return appsRepository.openWithCustomConfig(
      action: 'android.intent.action.MAIN',
      package: idApp,
      componentName: 'com.retroarch.browser.retroactivity.RetroActivityFuture',
      arguments: {
        'ROM': game.path,
        'LIBRETRO': libretro,
      },
    );
  }
}
