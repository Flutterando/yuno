import 'package:asp/asp.dart';

import '../models/game_config.dart';

final gameConfigState = Atom<GameConfig>(GameConfig());

final buildNumberState = Atom<String>('');
