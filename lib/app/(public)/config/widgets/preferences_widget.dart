import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';
import 'package:yuno/app/interactor/models/language_model.dart';

import '../../../core/widgets/background/background.dart';
import '../../../interactor/atoms/config_atom.dart';

class PreferencesWidget extends StatelessWidget {
  const PreferencesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RxBuilder(builder: (_) {
      return Material(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'theme'.i18n(),
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SizedBox(
                width: 300,
                child: DropdownButtonFormField<ThemeMode>(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'theme'.i18n(),
                  ),
                  value: gameConfigState.value.themeMode,
                  onChanged: (ThemeMode? newValue) {
                    if (newValue != null) {
                      saveConfig(
                        gameConfigState.value.copyWith(themeMode: newValue),
                      );
                    }
                  },
                  items: ThemeMode.values
                      .map<DropdownMenuItem<ThemeMode>>((ThemeMode value) {
                    return DropdownMenuItem<ThemeMode>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              const Gap(18),
              SizedBox(
                width: 300,
                child: DropdownButtonFormField<BackgroundType>(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'background_type'.i18n(),
                  ),
                  value: gameConfigState.value.backgroundType,
                  onChanged: (BackgroundType? newValue) {
                    if (newValue != null) {
                      saveConfig(
                        gameConfigState.value
                            .copyWith(backgroundType: newValue),
                      );
                    }
                  },
                  items: BackgroundType.values
                      .map<DropdownMenuItem<BackgroundType>>(
                          (BackgroundType value) {
                    return DropdownMenuItem<BackgroundType>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              const Gap(18),
              Text(
                'language'.i18n(),
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SizedBox(
                width: 300,
                child: DropdownButtonFormField<LanguageModel>(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'language'.i18n(),
                  ),
                  value: gameConfigState.value.language,
                  onChanged: (LanguageModel? newValue) {
                    if (newValue != null) {
                      saveConfig(
                        gameConfigState.value.copyWith(language: newValue),
                      );
                    }
                  },
                  items: languagesState.map<DropdownMenuItem<LanguageModel>>(
                      (LanguageModel value) {
                    return DropdownMenuItem<LanguageModel>(
                      value: value,
                      child: Text(value.title),
                    );
                  }).toList(),
                ),
              ),
              const Gap(18),
              Text(
                'sounds'.i18n(),
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SwitchListTile(
                title: Text('menu_sounds'.i18n()),
                value: gameConfigState.value.menuSounds,
                onChanged: (value) {
                  saveConfig(
                    gameConfigState.value.copyWith(menuSounds: value),
                  );
                },
              ),
              const Gap(18),
              Text(
                'controller'.i18n(),
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SwitchListTile(
                title: Text('swap_abxy'.i18n()),
                value: gameConfigState.value.swapABXY,
                onChanged: (value) {
                  saveConfig(
                    gameConfigState.value.copyWith(swapABXY: value),
                  );
                },
              ),
              const Gap(18),
              Text(
                'tabs'.i18n(),
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SwitchListTile(
                title: Text('show_all_tab'.i18n()),
                value: gameConfigState.value.showAllTab,
                onChanged: (value) {
                  saveConfig(
                    gameConfigState.value.copyWith(showAllTab: value),
                  );
                },
              ),
              const Gap(12),
              SwitchListTile(
                title: Text('show_favorite_tab'.i18n()),
                value: gameConfigState.value.showFavoriteTab,
                onChanged: (value) {
                  saveConfig(
                    gameConfigState.value.copyWith(showFavoriteTab: value),
                  );
                },
              ),
              const Gap(200),
            ],
          ),
        ),
      );
    });
  }
}
