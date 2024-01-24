import 'package:battery_plus/battery_plus.dart';

class BatteryModel {
  final int batteryLevel;
  final BatteryState batteryState;

  BatteryModel({
    required this.batteryLevel,
    required this.batteryState,
  });
}
