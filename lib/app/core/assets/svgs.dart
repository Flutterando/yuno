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
const snesSVG = 'assets/svgs/snes.svg';
const nesSVG = 'assets/svgs/nes.svg';
const psvitaSVG = 'assets/svgs/psvita.svg';
const neogeopocketSVG = 'assets/svgs/neogeopocket.svg';
const neogeopocketcolorSVG = 'assets/svgs/neogeopocketcolor.svg';
const neogeoSVG = 'assets/svgs/neogeo.svg';
const neogeocdSVG = 'assets/svgs/neogeocd.svg';
const n3dsSVG = 'assets/svgs/3ds.svg';
const ndsSVG = 'assets/svgs/nds.svg';
const gameboySVG = 'assets/svgs/gameboy.svg';
const gameboycolorSVG = 'assets/svgs/gameboycolor.svg';
const gameboyadvanceSVG = 'assets/svgs/gameboyadvance.svg';
const gamecubeSVG = 'assets/svgs/gamecube.svg';
const n64SVG = 'assets/svgs/n64.svg';
const wiiSVG = 'assets/svgs/wii.svg';
const wiiuSVG = 'assets/svgs/wiiu.svg';
const segagamegearSVG = 'assets/svgs/segagamegear.svg';
const segamastersystemSVG = 'assets/svgs/segamastersystem.svg';
const segagenesisSVG = 'assets/svgs/segacd.svg';
const segacdSVG = 'assets/svgs/segacd.svg';
const segasaturnSVG = 'assets/svgs/segasaturn.svg';
const dreamcastSVG = 'assets/svgs/dreamcast.svg';
const sega32xSVG = 'assets/svgs/sega32x.svg';
const turbografx16SVG = 'assets/svgs/turbografx16.svg';
const turbografxcdSVG = 'assets/svgs/turbografxcd.svg';

final _map = <String, BytesLoader>{};

BytesLoader getLoader(String path) {
  return _map[path]!;
}

Future<void> precacheCache(BuildContext context) async {
  for (final asset in [
    turbografx16SVG,
    turbografxcdSVG,
    segagamegearSVG,
    segamastersystemSVG,
    segacdSVG,
    segasaturnSVG,
    dreamcastSVG,
    sega32xSVG,
    gameboySVG,
    gameboycolorSVG,
    gameboyadvanceSVG,
    gamecubeSVG,
    n64SVG,
    wiiuSVG,
    wiiSVG,
    allSVG,
    switchSVG,
    favoriteSVG,
    androidSVG,
    ps1SVG,
    ps2SVG,
    pspSVG,
    snesSVG,
    nesSVG,
    psvitaSVG,
    neogeopocketSVG,
    neogeopocketcolorSVG,
    neogeoSVG,
    neogeocdSVG,
    n3dsSVG,
    ndsSVG,
  ]) {
    final loader = SvgAssetLoader(asset);
    await svg.cache
        .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    _map[asset] = loader;
  }
}
