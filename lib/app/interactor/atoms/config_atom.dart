import 'dart:ui';

import 'package:asp/asp.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:yuno/app/interactor/models/language_model.dart';

import '../models/battery_model.dart';
import '../models/game_config.dart';

final gameConfigState = Atom<GameConfig>(GameConfig());

final buildNumberState = Atom<String>('');

final batteryState = Atom<BatteryModel>(BatteryModel(
  batteryLevel: 0,
  batteryState: BatteryState.unknown,
));
final hoursState = Atom<String>('00:00');

Locale? localeResolution(Locale? locale, Iterable<Locale> supportedLocales) {
  if (supportedLocales.contains(locale)) {
    return locale;
  }

  return supportedLocales.firstWhere((l) {
    return l.languageCode == locale?.languageCode;
  }, orElse: () => supportedLocales.first);
}

const languagesState = <LanguageModel>[
  LanguageModel(
    title: 'English (USA)',
    locale: Locale('en', 'US'),
  ),
  LanguageModel(
    title: 'Português (Brasil)',
    locale: Locale('pt', 'BR'),
  ),
  LanguageModel(
    title: 'Español (España)',
    locale: Locale('es', 'ES'),
  ),
  LanguageModel(
    title: '日本語（日本）',
    locale: Locale('ja', 'JP'),
  ),
  LanguageModel(
    title: '简体中文（中国）',
    locale: Locale('zh', 'CN'),
  ),
  LanguageModel(
    title: '繁體中文（台灣））',
    locale: Locale('zh', 'TW'),
  ),
  LanguageModel(
    title: 'Русский (Россия)',
    locale: Locale('ru', 'RU'),
  ),
];

List<Locale> get supportedLocales =>
    languagesState.map((e) => e.locale).toList();
