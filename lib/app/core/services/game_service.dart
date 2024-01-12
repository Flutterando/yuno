// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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

extension GamepadButtonExtension on GamepadButton {
  static GamepadButton fromMethod(String method) {
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

class GameService {
  static const _channel = MethodChannel('br.com.flutterando.yuno/gamepad');
  final _state = Atom(
    GamepadButton.buttonA,
    pipe: throttleTime(const Duration(milliseconds: 200)),
  );
  GamepadButton get state => _state.value;

  GameService() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  void launchApp(String packageName) {
    _channel.invokeMethod('launchApp', {
      'packageName': packageName,
    });
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    try {
      final button = GamepadButtonExtension.fromMethod(call.method);
      _state.setValue(button);
    } catch (e) {
      debugPrint('Erro ao processar evento do gamepad: $e');
    }
  }

  void dispose() {
    _state.dispose();
  }
}
