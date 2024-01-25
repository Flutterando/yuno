import 'dart:ffi';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';

import '../../../interactor/actions/config_action.dart';
import '../../../interactor/actions/platform_action.dart';
import '../../../interactor/atoms/config_atom.dart';

class CoverSettingsWidget extends StatelessWidget {
  const CoverSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RxBuilder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'cover'.i18n(),
              style: theme.textTheme.titleMedium,
            ),
            const Gap(12),
            SwitchListTile(
              value: gameConfigState.value.enableIGDB,
              onChanged: (v) {
                saveConfig(gameConfigState.value.copyWith(enableIGDB: v));
              },
              title: const Text('IGDB'),
            ),
            const Gap(18),
            Text(
              'import_covers'.i18n(),
              style: theme.textTheme.titleMedium,
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextFormField(
                key: Key(beautifyPath(gameConfigState.value.coverFolder ?? '')),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'folder'.i18n(),
                  suffixIcon: const Icon(Icons.folder),
                ),
                initialValue:
                    beautifyPath(gameConfigState.value.coverFolder ?? ''),
                readOnly: true,
                onTap: () async {
                  final selectedDirectory = await getDirectory();

                  if (selectedDirectory != null) {
                    saveConfig(
                      gameConfigState.value.copyWith(
                        coverFolder: selectedDirectory,
                      ),
                    );
                  }
                },
              ),
            ),
            const Gap(12),
            Text(
              'import_covers_description'.i18n(),
              style: theme.textTheme.titleSmall,
            ),
          ],
        );
      },
    );
  }
}
