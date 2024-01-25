import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/models/game_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });
  group('ConfigAction |', () {
    final config = GameConfig(themeMode: ThemeMode.dark);
    test('Should save the configuration', () async {
      await saveConfig(config);
      final shared = await SharedPreferences.getInstance();
      final savedConfig = shared.getString('config');
      expect(savedConfig, equals(config.toJson()));
    });

    test('Should fetchConfig if json is null', () async {
      await fetchConfig();
      final shared = await SharedPreferences.getInstance();
      expect(shared.getString('config'), equals(config.toJson()));
    });

    test('Should not fetchConfig if json is not null', () async {
      await fetchConfig();
      final shared = await SharedPreferences.getInstance();
      expect(shared.getString('-'), isA<void>());
    });

    test('Should register time', () async {
      await registerHourListener();
      expect(hoursState.value,
          equals(DateFormat('HH:mm').format(DateTime(2024, 1, 25, 00, 00))));
    });
  });
}
