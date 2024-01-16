import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../interactor/services/gamepad_service.dart';

class AndroidGamepadService extends GamepadService {
  static const _channel = MethodChannel('br.com.flutterando.yuno/gamepad');

  AndroidGamepadService() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    try {
      final button = _fromMethod(call.method);
      setEvent(button);
    } catch (e) {
      debugPrint('Erro ao processar evento do gamepad: $e');
    }
  }

  GamepadButton _fromMethod(String method) {
    switch (method) {
      case 'buttonAPressed':
        return GamepadButton.buttonA;
      case 'buttonBPressed':
        return GamepadButton.buttonB;
      case 'buttonYPressed':
        return GamepadButton.buttonY;
      case 'buttonXPressed':
        return GamepadButton.buttonX;
      case 'startPressed':
        return GamepadButton.start;
      case 'selectPressed':
        return GamepadButton.select;
      case 'LBPressed':
        return GamepadButton.LB;
      case 'RBPressed':
        return GamepadButton.RB;
      case 'dpadUpPressed':
        return GamepadButton.dpadUp;
      case 'dpadDownPressed':
        return GamepadButton.dpadDown;
      case 'dpadRightPressed':
        return GamepadButton.dpadRight;
      case 'dpadLeftPressed':
        return GamepadButton.dpadLeft;
      case 'leftStickUp':
        return GamepadButton.leftStickUp;
      case 'leftStickDown':
        return GamepadButton.leftStickDown;
      case 'leftStickRight':
        return GamepadButton.leftStickRight;
      case 'leftStickLeft':
        return GamepadButton.leftStickLeft;
      default:
        throw ArgumentError('Método desconhecido: $method');
    }
  }
}
