import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:routefly/routefly.dart';
import 'package:yuno/app/interactor/atoms/app_atom.dart';
import 'package:yuno/app/interactor/atoms/game_atom.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

import '../../core/widgets/animated_title_app_bart.dart';
import '../../core/widgets/player_select.dart';
import '../../interactor/actions/config_action.dart';
import '../../interactor/actions/platform_action.dart';
import '../../interactor/models/embeds/game_category.dart';
import '../../interactor/models/embeds/player.dart';
import '../../interactor/models/platform_model.dart';

class EditPlatformPage extends StatefulWidget {
  const EditPlatformPage({super.key});

  @override
  State<EditPlatformPage> createState() => _EditPlatformPageState();
}

class _EditPlatformPageState extends State<EditPlatformPage> {
  late PlatformModel platform;
  late PlatformModel oldPlatform;

  @override
  void initState() {
    super.initState();
    platform = (Routefly.query.arguments as PlatformModel?)?.copyWith() ??
        PlatformModel.defaultInstance();
    oldPlatform = platform.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    final title = (platform.id == -1 ? 'new_platform' : 'edit_platform').i18n();
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isEditing = platform.id != -1;

    final categories = [
      if (isEditing) platform.category,
      ...categoriesFoSelectState
    ];

    return Scaffold(
      appBar: AnimatedTitleAppBar(
        title: title,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 350,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButtonFormField<GameCategory>(
                  decoration: InputDecoration(
                    enabled: !isEditing,
                    border: const OutlineInputBorder(),
                    labelText: 'platform_category'.i18n(),
                  ),
                  value:
                      platform.category.name.isEmpty ? null : platform.category,
                  onChanged: isEditing
                      ? null
                      : (GameCategory? newValue) {
                          if (newValue != null) {
                            setState(() {
                              platform = platform.copyWith(category: newValue);
                            });
                          }
                        },
                  items: categories.map((GameCategory value) {
                    return DropdownMenuItem<GameCategory>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
                const Gap(17),
                if (platform.category.id == 'android')
                  SizedBox(
                    height: size.height * 0.5,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 1,
                      ),
                      itemCount: appsState.value.length,
                      itemBuilder: (context, index) {
                        final app = appsState.value.elementAt(index);
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: MemoryImage(
                                    app.icon,
                                  ),
                                ),
                                const Gap(7),
                                Expanded(
                                  child: Text(
                                    app.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                const Gap(4),
                                Checkbox(
                                  value: platform.games.indexWhere((e) =>
                                          e.overradedPlayer?.app.package ==
                                          app.package) !=
                                      -1,
                                  onChanged: (isChecked) {
                                    final games = platform.games.toList();
                                    if (isChecked == true) {
                                      games.add(
                                        Game(
                                          name: app.name,
                                          description: '',
                                          image: '',
                                          overradedPlayer: Player(app: app),
                                          path: app.package,
                                        ),
                                      );
                                    } else {
                                      games.removeWhere((e) =>
                                          e.overradedPlayer?.app.package ==
                                          app.package);
                                    }

                                    setState(() {
                                      platform = platform.copyWith(
                                        games: games,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (platform.category.id != 'android')
                  PlayerSelect(
                    player: platform.player,
                    onChanged: (p) {
                      setState(() {
                        platform = platform.copyWith(player: p);
                      });
                    },
                  ),
                const Gap(17),
                if (platform.category.id != 'android')
                  TextFormField(
                    key: Key(beautifyPath(platform.folder)),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'folder'.i18n(),
                      suffixIcon: const Icon(Icons.folder),
                    ),
                    initialValue: beautifyPath(platform.folder),
                    readOnly: true,
                    onTap: () async {
                      final selectedDirectory = await getDirectory();

                      if (selectedDirectory != null) {
                        setState(() {
                          platform = platform.copyWith(
                            folder: selectedDirectory,
                          );
                        });
                      }
                    },
                  ),
                const Gap(17),
                if (platform.category.id != 'android')
                  TextFormField(
                    key: Key(beautifyPath(
                        '${platform.folderCover ?? platform.folder}_cover')),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'import_covers'.i18n(),
                      suffixIcon: const Icon(Icons.folder),
                    ),
                    initialValue:
                        beautifyPath(platform.folderCover ?? platform.folder),
                    readOnly: true,
                    onTap: () async {
                      final selectedDirectory = await getDirectory();

                      if (selectedDirectory != null) {
                        setState(() {
                          platform = platform.copyWith(
                            folderCover: selectedDirectory,
                          );
                        });
                      }
                    },
                  ),
                const Gap(50),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (platform.id != -1)
            FloatingActionButton(
              heroTag: 'delete',
              onPressed: () {
                deletePlatform(platform);
                if (context.mounted) {
                  Routefly.pop(context);
                }
              },
              child: const Icon(Icons.delete),
            ),
          if (platform.id != -1) const Gap(17),
          FloatingActionButton(
            heroTag: 'save',
            onPressed: () async {
              final result = platform.validator();
              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result),
                  ),
                );
                return;
              }

              if (oldPlatform.category.id == platform.category.id &&
                  platform.category.id == 'android') {
                final games = syncGames(oldPlatform.games, platform.games);
                platform = platform.copyWith(games: games);
              }

              Routefly.pop(context);

              if (isEditing) {
                await updatePlatform(platform);
              } else {
                await createPlatform(platform);
                platform = platformsState.value
                    .firstWhere((e) => e.category == platform.category);
              }
              await syncPlatform(platform);
            },
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
