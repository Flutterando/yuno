// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:yuno/app/core/widgets/background/background.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';

import 'language_model.dart';

enum GameViewType {
  grid,
  list,
}

class GameConfig {
  final ThemeMode themeMode;
  final BackgroundType backgroundType;
  final bool swapABXY;
  final bool menuSounds;
  final LanguageModel? language;
  final bool enableIGDB;
  final String? coverFolder;
  final bool showAllTab;
  final bool showFavoriteTab;
  final GameViewType gameView;

  GameConfig({
    this.themeMode = ThemeMode.system,
    this.swapABXY = false,
    this.menuSounds = true,
    this.language,
    this.gameView = GameViewType.grid,
    this.enableIGDB = true,
    this.backgroundType = BackgroundType.bubble,
    this.coverFolder,
    this.showAllTab = true,
    this.showFavoriteTab = true,
  });

  GameConfig copyWith({
    ThemeMode? themeMode,
    BackgroundType? backgroundType,
    bool? swapABXY,
    bool? menuSounds,
    LanguageModel? language,
    bool? enableIGDB,
    String? coverFolder,
    bool? showAllTab,
    bool? showFavoriteTab,
    GameViewType? gameView,
  }) {
    return GameConfig(
      gameView: gameView ?? this.gameView,
      themeMode: themeMode ?? this.themeMode,
      backgroundType: backgroundType ?? this.backgroundType,
      language: language ?? this.language,
      swapABXY: swapABXY ?? this.swapABXY,
      menuSounds: menuSounds ?? this.menuSounds,
      enableIGDB: enableIGDB ?? this.enableIGDB,
      coverFolder: coverFolder ?? this.coverFolder,
      showAllTab: showAllTab ?? this.showAllTab,
      showFavoriteTab: showFavoriteTab ?? this.showFavoriteTab,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameView': gameView.name,
      'themeMode': themeMode.name,
      'backgroundType': backgroundType.name,
      'swapABXY': swapABXY,
      'menuSounds': menuSounds,
      'enableIGDB': enableIGDB,
      'showAllTab': showAllTab,
      'showFavoriteTab': showFavoriteTab,
      if (coverFolder != null) 'coverFolder': coverFolder,
      if (language != null) 'locale': language!.locale.toString(),
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
      language: languagesState.firstWhereOrNull(
        (e) => e.locale.toString() == map['locale'],
      ),
      gameView: GameViewType.values.firstWhere(
        (e) => e.name == map['gameView'],
        orElse: () => GameViewType.grid,
      ),
      swapABXY: map['swapABXY'] as bool,
      menuSounds: map['menuSounds'] as bool,
      enableIGDB: map['enableIGDB'] ?? true,
      showAllTab: map['showAllTab'] ?? true,
      showFavoriteTab: map['showFavoriteTab'] ?? true,
      coverFolder: map['coverFolder'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GameConfig.fromJson(String source) =>
      GameConfig.fromMap(json.decode(source) as Map<String, dynamic>);
}
