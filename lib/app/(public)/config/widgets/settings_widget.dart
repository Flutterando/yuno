import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';

import '../../../core/widgets/background/background.dart';
import '../../../interactor/atoms/config_atom.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

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
                'Theme',
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SizedBox(
                width: 300,
                child: DropdownButtonFormField<ThemeMode>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Theme',
                  ),
                  value: gameConfigState.value.themeMode,
                  onChanged: (ThemeMode? newValue) {
                    if (newValue != null) {
                      saveConfig(
                        gameConfigState.value.copyWith(themeMode: newValue),
                      );
                    }
                  },
                  items: ThemeMode.values.map<DropdownMenuItem<ThemeMode>>((ThemeMode value) {
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Background type',
                  ),
                  value: gameConfigState.value.backgroundType,
                  onChanged: (BackgroundType? newValue) {
                    if (newValue != null) {
                      saveConfig(
                        gameConfigState.value.copyWith(backgroundType: newValue),
                      );
                    }
                  },
                  items: BackgroundType.values.map<DropdownMenuItem<BackgroundType>>((BackgroundType value) {
                    return DropdownMenuItem<BackgroundType>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              const Gap(18),
              Text(
                'Sounds',
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SwitchListTile(
                title: const Text('Menu Sounds'),
                value: gameConfigState.value.menuSounds,
                onChanged: (value) {
                  saveConfig(
                    gameConfigState.value.copyWith(menuSounds: value),
                  );
                },
              ),
              const Gap(18),
              Text(
                'Controller',
                style: theme.textTheme.titleMedium,
              ),
              const Gap(12),
              SwitchListTile(
                title: const Text('Swap ABXY'),
                value: gameConfigState.value.swapABXY,
                onChanged: (value) {
                  saveConfig(
                    gameConfigState.value.copyWith(swapABXY: value),
                  );
                },
              ),
              const Gap(100),
            ],
          ),
        ),
      );
    });
  }
}
