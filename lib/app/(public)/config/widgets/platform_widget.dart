import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yuno/app/core/widgets/animated_floating_action_button.dart';
import 'package:yuno/app/interactor/atoms/platform_atom.dart';

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
          itemCount: platforms.length,
          itemBuilder: (_, index) {
            final platform = platforms[index];
            return ListTile(
              leading: CircleAvatar(
                child: SvgPicture.asset(
                  platform.category.image,
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
                    platform.player?.app.package ?? 'No player',
                    maxLines: 1,
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.sync),
                    onPressed: () async {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {},
                  ),
                ],
              ),
              onTap: () async {},
            );
          },
        ),
        floatingActionButton: AnimatedFloatingActionButton(
          onPressed: () async {},
          label: 'Add Platform',
          icon: Icons.add,
          animation: transitionAnimation,
        ),
      );
    });
  }
}
