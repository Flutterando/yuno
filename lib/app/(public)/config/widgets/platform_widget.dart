import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routefly/routefly.dart';
import 'package:yuno/app/core/assets/svgs.dart';
import 'package:yuno/app/core/widgets/animated_floating_action_button.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';

import '../../../../routes.dart';
import '../../../core/widgets/animated_sync_button.dart';
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
      const snackbar = SnackBar(
        content: Text('Syncing platform...'),
        duration: Duration(seconds: 2),
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

      return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: platforms.length,
          itemBuilder: (_, index) {
            final platform = platforms[index];
            var playerName = '';

            if (platform.category.id == 'android') {
              playerName = 'Android';
            } else {
              playerName = platform.player?.app.package ?? 'No player';
            }
            return ListTile(
              leading: CircleAvatar(
                child: SvgPicture(
                  getLoader(platform.category.image),
                  width: 24,
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
                    isSyncing: platformSyncState.value.contains(platform.id),
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
          label: 'Add Platform',
          icon: Icons.add,
          animation: widget.transitionAnimation,
        ),
      );
    });
  }
}
