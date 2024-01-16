import 'package:yuno/injector.dart';

import '../atoms/gamepad_atom.dart';
import '../services/gamepad_service.dart';

void registerGamepad() {
  final gamepad = injector.get<GamepadService>();
  gamepad.setHandleFunction(gamepadState.setValue);
}
