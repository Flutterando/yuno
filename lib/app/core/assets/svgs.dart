// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const allSVG = 'assets/svgs/all.svg';
const switchSVG = 'assets/svgs/switch.svg';
const favoriteSVG = 'assets/svgs/favorite.svg';
const androidSVG = 'assets/svgs/android.svg';
const ps1SVG = 'assets/svgs/ps1.svg';
const ps2SVG = 'assets/svgs/ps2.svg';
const pspSVG = 'assets/svgs/psp.svg';

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
