import 'package:flutter/material.dart';

const switchPNG = 'assets/static/switch.png';

Future<void> precacheCache(BuildContext context) async {
  await precacheImage(const AssetImage(switchPNG), context);
}
