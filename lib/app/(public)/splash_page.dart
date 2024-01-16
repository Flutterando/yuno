import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:routefly/routefly.dart';
import 'package:yuno/app/interactor/actions/gamepad_action.dart';
import 'package:yuno/routes.dart';

import '../core/assets/images.dart' as images;
import '../core/assets/sounds.dart' as sounds;
import '../core/assets/svgs.dart' as svgs;
import '../interactor/actions/apps_action.dart' as apps;
import '../interactor/actions/game_action.dart' as game;

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    registerGamepad();
    Future.wait([
      apps.fetchApps(),
      game.firstInitialization(context),
      svgs.precacheCache(context),
      images.precacheCache(context),
      sounds.precacheCache(),
      Future.delayed(const Duration(seconds: 2)),
    ]).whenComplete(() {
      sounds.introSound();
      Routefly.navigate(routePaths.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(35),
          Text(
            'YuNO',
            style: GoogleFonts.lemon(
              fontSize: 47.5,
            ),
          ),
          const Gap(7),
          LoadingAnimationWidget.staggeredDotsWave(
            size: 40,
            color: theme.colorScheme.onBackground,
          ),
        ],
      ),
    );
  }
}
