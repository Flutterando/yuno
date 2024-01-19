import 'dart:convert';

import 'package:yuno/app/interactor/atoms/app_atom.dart';

import '../app_model.dart';
import 'game.dart';

class Player {
  final AppModel app;
  final String? extra;

  Player({
    required this.app,
    this.extra,
  });

  Player copyWith({
    AppModel? app,
    String? extra,
  }) {
    return Player(
      app: app ?? this.app,
      extra: extra ?? this.extra,
    );
  }

  static Player fromJson(String source) {
    final map = json.decode(source);
    return Player(
      app: appsState.value.firstWhere((e) => e.package == map['packageId']),
      extra: map['extra'] as String?,
    );
  }

  String toJson() {
    final map = {
      "packageId": app.package,
      "extra": extra,
    };

    return json.encode(map);
  }
}

class PlayerIntent {
  final String action;
  final String package;
  final String? componentName;
  final String? data;
  final String? type;
  final Map<String, dynamic>? arguments;

  PlayerIntent({
    required this.action,
    required this.package,
    this.componentName,
    this.data,
    this.arguments,
    this.type,
  });

  PlayerIntent parse({String? fileGameUri, String? fileGamePath, String? extra,}) {
    if (arguments == null) {
      return this;
    }
    var newArguments = arguments;
    var newData = data;


    if(fileGameUri != null){
      newArguments = replaceMap(newArguments, 'fileGameUri', fileGameUri);
      newData = replaceVariable(newData, 'fileGameUri', fileGameUri);
      newData = replaceVariable(newData, 'fileGame', fileGameUri);
    }

    if(fileGamePath != null){
      newArguments = replaceMap(newArguments, 'fileGamePath', fileGamePath);
    }

    if(extra != null){
      newArguments = replaceMap(newArguments, 'extra', extra);
    }

    return PlayerIntent(
      action: action,
      package: package,
      componentName: componentName,
      type: type,
      data: newData,
      arguments: newArguments,
    );
  }

  String? replaceVariable(String? value, String variable, String replaceValue) {
    if (value == null) {
      return null;
    }
    var regex = RegExp(r'\$\{' + RegExp.escape(variable) + r'\}');
    return value.replaceAll(regex, replaceValue);
  }

  Map<String, dynamic> replaceMap(
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
