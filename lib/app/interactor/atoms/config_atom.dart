import 'dart:ui';

import 'package:asp/asp.dart';

import '../models/game_config.dart';

final gameConfigState = Atom<GameConfig>(GameConfig());

final buildNumberState = Atom<String>('');

const supportedLocales = [
  Locale('en', 'US'),
  Locale('es', 'ES'),
  Locale('pt', 'BR'),
];
