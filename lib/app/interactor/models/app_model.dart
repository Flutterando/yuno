import 'package:flutter/foundation.dart';

class AppModel {
  final String name;
  final String package;
  final Uint8List icon;

  AppModel({
    required this.name,
    required this.package,
    required this.icon,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppModel && other.name == name && other.package == package;
  }

  @override
  int get hashCode => name.hashCode ^ package.hashCode;
}
