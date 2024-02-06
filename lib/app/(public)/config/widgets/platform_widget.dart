import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:routefly/routefly.dart';
import 'package:yuno/app/core/widgets/animated_floating_action_button.dart';
import 'package:yuno/app/core/widgets/category_image_widget.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';

import '../../../../routes.dart';
import '../../../core/widgets/animated_sync_button.dart';
import '../../../core/widgets/no_items_widget.dart';
import '../../../interactor/actions/platform_action.dart';

class PlatformWidget extends StatefulWidget {
  final Animation<double> transitionAnimation;

  const PlatformWidget({
    super.key,
    required this.transitionAnimation,
  });

  @override
  State<PlatformWidget> createState() => _PlatformWidgetState();
}

class _PlatformWidgetState extends State<PlatformWidget> {
  bool checkPlatformSyncing() {
    if (platformSyncState.value.isNotEmpty) {
      final snackbar = SnackBar(
        content: Text('syncing_platform'.i18n()),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (_) {
      final platforms = platformsState.value;
      final platformSync = platformSyncState.value;

      return Scaffold(
        body: platforms.isEmpty
            ? Material(
                child: Center(
                  child: NoItemWidget(
                    title: 'no_platforms_found'.i18n(),
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: platforms.length,
                itemBuilder: (_, index) {
                  final platform = platforms[index];
                  var playerName = '';

                  if (platform.category.id == 'android') {
                    playerName = 'Android';
                  } else {
                    playerName =
                        platform.player?.app.package ?? 'no_player'.i18n();
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      child: CategoryImageWidget(
                        image: platform.category.image,
                      ),
                    ),
                    title: Text(platform.category.name),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.play_arrow_outlined,
                          size: 12,
                        ),
                        Text(
                          playerName,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSyncButton(
                          isSyncing: platformSync.contains(platform.id),
                          onLongPressed: () async {
                            if (checkPlatformSyncing()) {
                              return;
                            }
                            final snackbar =
                                SnackBar(content: Text('deep_sync'.i18n()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            final games = platform.games
                                .map((e) => e.copyWith(isSynced: false))
                                .toList();
                            await syncPlatform(platform.copyWith(games: games));
                          },
                          onPressed: () async {
                            if (checkPlatformSyncing()) {
                              return;
                            }
                            await syncPlatform(platform);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            if (checkPlatformSyncing()) {
                              return;
                            }
                            Routefly.push(
                              routePaths.config.editPlatform,
                              arguments: platform,
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () async {},
                  );
                },
              ),
        floatingActionButton: AnimatedFloatingActionButton(
          onPressed: () async {
            if (checkPlatformSyncing()) {
              return;
            }
            Routefly.push(routePaths.config.editPlatform);
          },
          label: 'add_platorm'.i18n(),
          icon: Icons.add,
          animation: widget.transitionAnimation,
        ),
      );
    });
  }
}
