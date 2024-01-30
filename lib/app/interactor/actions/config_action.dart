import 'dart:async';

import 'package:intl/intl.dart';
import 'package:yuno/app/interactor/models/battery_model.dart';
import 'package:yuno/app/interactor/models/game_config.dart';
import 'package:yuno/injector.dart';

import '../atoms/config_atom.dart';
import '../repositories/config_repository.dart';
import '../repositories/device_repository.dart';
import 'platform_action.dart';

Future<void> saveConfig(GameConfig config) async {
  final repository = injector.get<ConfigRepository>();
  gameConfigState.value = config;
  await repository.saveConfig(config);
}

Future<void> fetchConfig() async {
  final repository = injector.get<ConfigRepository>();
  gameConfigState.value = await repository.getConfig();
}

Future<void> openUrl(Uri uri) async {
  final repository = injector.get<ConfigRepository>();
  await repository.openUrl(uri);
}

String beautifyPath(String dir) {
  final path = convertContentUriToFilePath(dir);
  return path.replaceAll('/storage/emulated/0', '');
}

StreamSubscription<BatteryModel>? _batterySubscription;

Future<void> registerBatteryListener() async {
  final repository = injector.get<DeviceRepository>();
  _batterySubscription?.cancel();
  _batterySubscription =
      repository.batteryStatus().listen(batteryState.setValue);
}

Timer? timer;

Future<void> registerHourListener() async {
  timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
    hoursState.value = DateFormat('HH:mm').format(DateTime.now());
  });
}
