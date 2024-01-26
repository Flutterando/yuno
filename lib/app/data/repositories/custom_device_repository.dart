import 'package:battery_plus/battery_plus.dart';
import 'package:yuno/app/interactor/models/battery_model.dart';

import '../../interactor/repositories/device_repository.dart';

class CustomDeviceRepository implements DeviceRepository {
  final _battery = Battery();

  @override
  Stream<BatteryModel> batteryStatus() {
    return _battery.onBatteryStateChanged.asyncMap(
      (event) async {
        return BatteryModel(
          batteryLevel: await _battery.batteryLevel,
          batteryState: event,
        );
      },
    );
  }
}
