import 'package:auto_injector/auto_injector.dart';
import 'package:yuno/app/core/services/game_service.dart';

final injector = AutoInjector(
  on: (i) {
    i.addSingleton(GameService.new);
  },
);
