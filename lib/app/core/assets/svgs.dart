// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const allSVG = 'assets/static/all.svg';
const switchSVG = 'assets/static/switch.svg';
const favoriteSVG = 'assets/static/favorite.svg';
const androidSVG = 'assets/static/android.svg';
const ps1SVG = 'assets/static/ps1.svg';
const ps2SVG = 'assets/static/ps2.svg';
const pspSVG = 'assets/static/psp.svg';

Future<void> precacheCache(BuildContext context) async {
  for (final asset in [
    allSVG,
    switchSVG,
    favoriteSVG,
    androidSVG,
    ps1SVG,
    ps2SVG,
    pspSVG,
  ]) {
    final loader = SvgAssetLoader(asset);
    await svg.cache
        .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }
}
