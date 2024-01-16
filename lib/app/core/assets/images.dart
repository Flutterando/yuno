// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

const flutterandoPNG = 'assets/images/flutterando.jpeg';
const fteamPNG = 'assets/images/fteam.jpeg';

Future<void> precacheCache(BuildContext context) async {
  for (final asset in [
    flutterandoPNG,
    fteamPNG,
  ]) {
    await precacheImage(AssetImage(asset), context);
  }
}
