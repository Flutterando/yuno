import 'package:collection/collection.dart';
import 'package:yuno/app/interactor/models/player.dart';

import '../../../injector.dart';
import '../atoms/app_atom.dart';
import '../models/app_model.dart';
import '../repositories/apps_repository.dart';

Future<void> fetchApps() async {
  final repository = injector.get<AppsRepository>();
  final models = await repository.getInstalledApps();

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
  final repository = injector.get<AppsRepository>();
  await repository.openApp(app);
}

Future<void> openAppSettings(AppModel app) async {
  final repository = injector.get<AppsRepository>();
  await repository.openAppSettings(app);
}

Future<void> openConfiguration() async {
  final repository = injector.get<AppsRepository>();
  await repository.openConfiguration();
}

Future<void> openIntent(PlayerIntent intent) async {
  final repository = injector.get<AppsRepository>();
  await repository.openIntent(intent);
}
