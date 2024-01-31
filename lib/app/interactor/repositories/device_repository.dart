import '../models/battery_model.dart';

abstract class DeviceRepository {
  Stream<BatteryModel> batteryStatus();
}
