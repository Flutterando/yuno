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

class PlatformWidget extends StatelessWidget {
  final Animation<double> transitionAnimation;

  const PlatformWidget({
    super.key,
    required this.transitionAnimation,
  });

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
                      if(isPlatformSyncing) {
                        return;
                      }
                        await syncPlatform(platform);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      if(isPlatformSyncing) {
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
            Routefly.push(routePaths.config.editPlatform);
          },
          label: 'Add Platform',
          icon: Icons.add,
          animation: transitionAnimation,
        ),
      );
    });
  }
}
