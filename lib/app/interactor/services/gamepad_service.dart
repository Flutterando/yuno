enum GamepadButton {
  buttonA,
  buttonB,
  buttonX,
  buttonY,
  leftStickUp,
  leftStickDown,
  leftStickLeft,
  leftStickRight,
  dpadUp,
  dpadDown,
  dpadLeft,
  dpadRight,
  leftThumb,
  rightThumb,
  start,
  select,
  LB,
  RB,
}

abstract class GamepadService {
  void Function(GamepadButton)? _handleFunction;

  setHandleFunction(void Function(GamepadButton) handleFunction) {
    _handleFunction = handleFunction;
  }

  void setEvent(GamepadButton newState) {
    _handleFunction?.call(newState);
  }
}
