import 'package:android_intent_plus/android_intent.dart' as android_intent;
import 'package:android_intent_plus/flag.dart' as flag;
import 'package:install_or_uninstall_app_listener/install_or_uninstall_app_listener.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart' as installed_apps;
import 'package:yuno/app/interactor/models/app_model.dart';
import 'package:yuno/app/interactor/models/embeds/player.dart';
import 'package:yuno/app/interactor/repositories/apps_repository.dart';

class AndroidAppsRepository implements AppsRepository {
  @override
  Future<Set<AppModel>> getInstalledApps() async {
    List<AppInfo> apps =
        await installed_apps.InstalledApps.getInstalledApps(true, true);

    return apps.map((e) {
      return AppModel(
        name: e.name!,
        package: e.packageName!,
        icon: e.icon!,
      );
    }).toSet();
  }

  @override
  Future<void> openApp(AppModel app) {
    return installed_apps.InstalledApps.startApp(app.package);
  }

  @override
  Future<void> openAppSettings(AppModel app) {
    return installed_apps.InstalledApps.openSettings(app.package);
  }

  @override
  Future<void> openConfiguration() async {
    const intent = android_intent.AndroidIntent(
      action: 'android.settings.SETTINGS',
    );

    await intent.launch();
  }

  @override
  Future<void> openIntent(PlayerIntent intent) async {
    final newIntent = android_intent.AndroidIntent(
      action: intent.action,
      package: intent.package,
      componentName: intent.componentName,
      category: intent.category,
      data: intent.data,
      type: intent.type,
      arguments: intent.arguments,
      flags: <int>[
        flag.Flag.FLAG_ACTIVITY_NEW_TASK,
        flag.Flag.FLAG_ACTIVITY_CLEAR_TASK,
      ],
    );

    return newIntent.launch();
  }

  @override
  Stream<String> installAndUninstallListener() {
    return InstallOrUninstallAppListener.onAppInstallUninstall;
  }
}
