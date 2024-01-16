import 'package:yuno/app/interactor/models/app_model.dart';

abstract class AppsRepository {
  Future<Set<AppModel>> getInstalledApps();

  Future<void> openApp(AppModel app);

  Future<void> openAppSettings(AppModel app);

  Future<void> openConfiguration();

  Future<void> openWithCustomConfig({
    required String action,
    String package,
    String? componentName,
    Map<String, dynamic> arguments = const {},
  });
}
