import 'package:yuno/app/interactor/models/game_config.dart';
import 'package:yuno/injector.dart';

import '../atoms/config_atom.dart';
import '../repositories/config_repository.dart';

Future<void> saveConfig(GameConfig config) async {
  final repository = injector.get<ConfigRepository>();
  gameConfigState.value = config;
  await repository.saveConfig(config);
}

Future<void> fetchConfig() async {
  final repository = injector.get<ConfigRepository>();
  gameConfigState.value = await repository.getConfig();
}
