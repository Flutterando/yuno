// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

const switchPNG = 'assets/static/switch.png';
const allPNG = 'assets/static/all.png';
const favoritePNG = 'assets/static/favorite.png';
const androidPNG = 'assets/static/android.png';

Future<void> precacheCache(BuildContext context) async {
  await precacheImage(const AssetImage(switchPNG), context);
  await precacheImage(const AssetImage(allPNG), context);
  await precacheImage(const AssetImage(favoritePNG), context);
  await precacheImage(const AssetImage(androidPNG), context);
}
