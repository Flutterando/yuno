import 'package:android_intent_plus/android_intent.dart' as android_intent;
import 'package:collection/collection.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart' as installed_apps;

import '../atoms/app_atom.dart';
import '../models/app_model.dart';

Future<void> fetchApps() async {
  List<AppInfo> apps =
      await installed_apps.InstalledApps.getInstalledApps(true, true);

  final models = apps.map((e) {
    return AppModel(
      name: e.name!,
      package: e.packageName!,
      icon: e.icon!,
    );
  }).toSet();

  if (const DeepCollectionEquality().equals(appsState.value, models)) {
    return;
  }

  for (var candidateApp in models) {
    if (!appsState.value.contains(candidateApp)) {
      appsState.value.add(candidateApp);
    }
  }
  appsState.value.removeWhere((item) => !models.contains(item));

  appsState();
}

Future<void> openApp(AppModel app) async {
  await installed_apps.InstalledApps.startApp(app.package);
}

Future<void> openAppSettings(AppModel app) async {
  await installed_apps.InstalledApps.openSettings(app.package);
}

Future<void> openConfiguration() async {
  const intent = android_intent.AndroidIntent(
    action: 'android.settings.SETTINGS',
  );

  intent.launch();
}
