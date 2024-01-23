// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yuno/app/core/widgets/background/background.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';

class GameConfig {
  final ThemeMode themeMode;
  final BackgroundType backgroundType;
  final bool swapABXY;
  final bool menuSounds;
  final Locale locale;

  GameConfig({
    this.themeMode = ThemeMode.system,
    this.swapABXY = false,
    this.menuSounds = true,
    this.locale = const Locale('en', 'US'),
    this.backgroundType = BackgroundType.bubble,
  });

  GameConfig copyWith({
    ThemeMode? themeMode,
    BackgroundType? backgroundType,
    bool? swapABXY,
    bool? menuSounds,
    Locale? locale,
  }) {
    return GameConfig(
      themeMode: themeMode ?? this.themeMode,
      backgroundType: backgroundType ?? this.backgroundType,
      locale: locale ?? this.locale,
      swapABXY: swapABXY ?? this.swapABXY,
      menuSounds: menuSounds ?? this.menuSounds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'themeMode': themeMode.name,
      'backgroundType': backgroundType.name,
      'swapABXY': swapABXY,
      'menuSounds': menuSounds,
      'locale': locale.toString(),
    };
  }

  factory GameConfig.fromMap(Map<String, dynamic> map) {
    return GameConfig(
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == map['themeMode'],
        orElse: () => ThemeMode.system,
      ),
      backgroundType: BackgroundType.values.firstWhere(
        (e) => e.name == map['backgroundType'],
        orElse: () => BackgroundType.bubble,
      ),
      locale: supportedLocales.firstWhere(
        (e) => e.toString() == map['locale'],
        orElse: () => const Locale('en', 'US'),
      ),
      swapABXY: map['swapABXY'] as bool,
      menuSounds: map['menuSounds'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameConfig.fromJson(String source) => GameConfig.fromMap(json.decode(source) as Map<String, dynamic>);
}
