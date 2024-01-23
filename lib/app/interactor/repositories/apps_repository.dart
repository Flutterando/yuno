import 'package:yuno/app/interactor/models/app_model.dart';

import '../models/embeds/player.dart';

abstract class AppsRepository {
  Future<Set<AppModel>> getInstalledApps();

  Future<void> openApp(AppModel app);

  Future<void> openAppSettings(AppModel app);

  Future<void> openConfiguration();

  Future<void> openIntent(PlayerIntent intent);

  Stream<String> installAndUninstallListener();
}
