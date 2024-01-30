import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yuno/app/interactor/actions/gamepad_action.dart';
import 'package:yuno/app/interactor/atoms/gamepad_atom.dart';
import 'package:yuno/app/interactor/services/gamepad_service.dart';
import 'package:yuno/injector.dart';

class GamepadServiceMock extends Mock implements GamepadService {}

void main() {
  setUpAll(() {
    registerInjectAndroidConfig(injector);
  });
  test('Should register gamepad', () {
    final service = GamepadServiceMock();
    injector.replaceInstance<GamepadService>(service);
    registerGamepad();
    verify(() => service.setHandleFunction(gamepadState.setValue)).called(1);
  });
}
