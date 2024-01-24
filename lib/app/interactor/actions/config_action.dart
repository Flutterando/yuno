import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:intl/intl.dart';
import 'package:yuno/app/interactor/models/battery_model.dart';
import 'package:yuno/app/interactor/models/game_config.dart';
import 'package:yuno/injector.dart';

import '../atoms/config_atom.dart';
import '../repositories/config_repository.dart';

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

final _battery = Battery();
StreamSubscription<BatteryState>? _batterySubscription;

Future<void> registerBatteryListener() async {
  _batterySubscription?.cancel();
  _batterySubscription = _battery.onBatteryStateChanged.listen(
    (BatteryState state) async {
      batteryState.value = BatteryModel(
        batteryLevel: await _battery.batteryLevel,
        batteryState: state,
      );
    },
  );
}

Timer? timer;

Future<void> registerHourListener() async {
  timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
    hoursState.value = DateFormat('HH:mm').format(DateTime.now());
  });
}
