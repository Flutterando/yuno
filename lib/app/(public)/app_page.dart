import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routefly/routefly.dart';

import '../core/assets/sounds.dart' as sounds;
import '../core/assets/static.dart' as img;
import '../interactor/actions/game_action.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.wait([
      fetchGamesAction(),
      img.precacheCache(context),
      sounds.precacheCache(),
    ]).whenComplete(() {
      sounds.introSound();
      Routefly.navigate('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text(
          'YuNO',
          style: GoogleFonts.lemon(
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
