import 'package:asp/asp.dart';

import '../services/gamepad_service.dart';

final gamepadState = Atom<GamepadButton>(
  GamepadButton.buttonA,
  pipe: throttleTime(const Duration(milliseconds: 100)),
);
