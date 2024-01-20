import 'dart:io';
import 'dart:math';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:routefly/routefly.dart';
import 'package:yuno/app/interactor/atoms/app_atom.dart';
import 'package:yuno/app/interactor/atoms/game_atom.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';
import 'package:yuno/app/interactor/models/app_model.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

import '../../core/constants/retroarch_cores.dart';
import '../../core/widgets/animated_title_app_bart.dart';
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

  @override
  void initState() {
    super.initState();
    platform = (Routefly.query.arguments as PlatformModel?)?.copyWith() ??
        PlatformModel.defaultInstance();
  }

  @override
  Widget build(BuildContext context) {
    final title = platform.id == -1 ? 'New platform' : 'Edit platform';
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
                    labelText: 'Platform Category',
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
                                            isSynced: true,
                                            overradedPlayer: Player(app: app),
                                            path: ''),
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<AppModel>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Player app',
                        ),
                        value: platform.player?.app,
                        selectedItemBuilder: (BuildContext context) {
                          return appsState.value.map((AppModel value) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundImage: MemoryImage(
                                    value.icon,
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  value.name.substring(
                                    0,
                                    min(value.name.length, 30),
                                  ),
                                ),
                              ],
                            );
                          }).toList();
                        },
                        onChanged: (AppModel? newValue) {
                          if (newValue != null) {
                            setState(() {
                              final player =
                                  platform.player?.copyWith(app: newValue) ??
                                      Player(app: newValue);

                              platform = platform.copyWith(
                                player: player,
                              );
                            });
                          }
                        },
                        items: appsState.value.map((AppModel value) {
                          return DropdownMenuItem<AppModel>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 9,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      value.icon,
                                    ),
                                  ),
                                  const Gap(12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        value.name.substring(
                                          0,
                                          min(value.name.length, 30),
                                        ),
                                      ),
                                      Text(
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                        value.package.substring(
                                          0,
                                          min(value.package.length, 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      if (platform.player?.app.package
                              .startsWith('com.retroarch') ==
                          true)
                        const Gap(17),
                      if (platform.player?.app.package
                              .startsWith('com.retroarch') ==
                          true)
                        Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Retroarch Core',
                                ),
                                value: platform.player?.extra,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      platform = platform.copyWith(
                                        player: platform.player
                                            ?.copyWith(extra: newValue),
                                      );
                                    });
                                  }
                                },
                                items: retroarchCores.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.info_outline),
                            )
                          ],
                        ),
                      const Gap(17),
                      TextFormField(
                        key: Key(beautifyPath(platform.folder)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Folder',
                        ),
                        initialValue: beautifyPath(platform.folder),
                        readOnly: true,
                        onTap: () async {
                          final selectedDirectory = await getDirectoryPath();

                          if (selectedDirectory != null) {
                            setState(() {
                              platform = platform.copyWith(
                                folder: selectedDirectory,
                              );
                            });
                          }
                        },
                      ),
                    ],
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


              Routefly.pop(context);

              if (isEditing) {
                updatePlatform(platform);
              } else {
                  await createPlatform(platform);
                  platform = platformsState.value.firstWhere((e) => e.category == platform.category);
                  await syncPlatform(platform);
              }
            },
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }

  String beautifyPath(String dir) {
    final path = convertContentUriToFilePath(dir);
    return path.replaceAll('/storage/emulated/0', '');
  }
}
