import 'dart:convert';

import 'package:yuno/app/interactor/atoms/app_atom.dart';

import '../app_model.dart';

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
  final String? category;
  final String? data;
  final String? type;
  final Map<String, dynamic>? arguments;

  PlayerIntent({
    required this.action,
    required this.package,
    this.componentName,
    this.category,
    this.data,
    this.arguments,
    this.type,
  });
}
