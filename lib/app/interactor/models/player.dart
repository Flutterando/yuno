import 'app_model.dart';
import 'game.dart';

class Player {
  final AppModel app;
  final String? extra;

  Player({
    required this.app,
    this.extra,
  });
}

class PlayerIntent {
  final String action;
  final String package;
  final String? componentName;
  final Map<String, dynamic>? arguments;

  PlayerIntent({
    required this.action,
    required this.package,
    this.componentName,
    this.arguments,
  });

  PlayerIntent parse(Game game) {
    if (arguments == null) {
      return this;
    }
    var newArguments = replaceVariables(arguments, 'fileGame', game.path);
    newArguments = replaceVariables(
        newArguments, 'extra', game.platform.player?.extra ?? '');
    return PlayerIntent(
      action: action,
      package: package,
      componentName: componentName,
      arguments: newArguments,
    );
  }

  Map<String, dynamic> replaceVariables(
      Map<String, dynamic>? map, String variable, String replaceValue) {
    if (map == null) {
      return {};
    }
    var copy = Map<String, dynamic>.from(map);
    var regex = RegExp(r'\$\{' + RegExp.escape(variable) + r'\}');

    copy.updateAll((key, value) {
      if (value is String) {
        return value.replaceAll(regex, replaceValue);
      }
      return value;
    });

    copy.forEach((key, value) {
      if (key.contains(regex)) {
        var newKey = key.replaceAll(regex, replaceValue);
        copy[newKey] = copy.remove(key);
      }
    });

    return copy;
  }
}
