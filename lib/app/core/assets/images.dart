// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

// const myimagePNG = 'assets/image/myimage.png';

Future<void> precacheCache(BuildContext context) async {
  for (final asset in [
    // myimagePNG
  ]) {
    await precacheImage(AssetImage(asset), context);
  }
}
