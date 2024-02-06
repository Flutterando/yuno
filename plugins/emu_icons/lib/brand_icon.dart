import 'package:emu_icons/src/icons/n64_logo.dart';
import 'package:emu_icons/src/icons/neo_geo_cd_logo.dart';
import 'package:emu_icons/src/icons/nes_controll_logo.dart';
import 'package:emu_icons/src/icons/nintendo_logo.dart';
import 'package:emu_icons/src/icons/ps2_logo.dart';
import 'package:emu_icons/src/icons/ps_one_logo.dart';
import 'package:emu_icons/src/icons/retroarch_logo.dart';
import 'package:emu_icons/src/icons/sega_genesis_logo.dart';
import 'package:emu_icons/src/icons/switch_logo.dart';
import 'package:flutter/widgets.dart';

import 'emu_icons.dart';
import 'src/icons/android_logo.dart';
import 'src/icons/game_cube_logo.dart';
import 'src/icons/mame_logo.dart';
import 'src/icons/neo_geo_logo.dart';
import 'src/icons/neo_geo_pocket_logo.dart';
import 'src/icons/ps_vita_logo.dart';
import 'src/icons/psp_logo.dart';
import 'src/icons/sega_logo.dart';

class BrandLogo {
  final Widget logo;
  final String logoName;

  const BrandLogo({
    required this.logo,
    required this.logoName,
  });
}

BrandLogo getBrandLogo(BrandLogoName logoName) {
  switch (logoName) {
    case BrandLogoName.android:
      return const BrandLogo(
        logo: AndroidLogo(),
        logoName: 'Android',
      );
    case BrandLogoName.gameCube:
      return const BrandLogo(
        logo: GameCubeLogo(),
        logoName: 'Game Cube',
      );
    case BrandLogoName.mame:
      return const BrandLogo(
        logo: MameLogo(),
        logoName: 'Mame',
      );
    case BrandLogoName.n64:
      return const BrandLogo(
        logo: N64Logo(),
        logoName: 'Nintendo 64',
      );
    case BrandLogoName.neoGeoCD:
      return const BrandLogo(
        logo: NeoGeoCDLogo(),
        logoName: 'Neo Geo CD',
      );
    case BrandLogoName.neoGeo:
      return const BrandLogo(
        logo: NeoGeoLogo(),
        logoName: 'Neo Geo',
      );
    case BrandLogoName.neoGeoPocket:
      return const BrandLogo(
        logo: NeoGeoPocketLogo(color: Color(0xffE81A2E)),
        logoName: 'NeoGeo Pocket',
      );
    case BrandLogoName.neoGeoPocketColor:
      return const BrandLogo(
        logo: NeoGeoPocketLogo(),
        logoName: 'NeoGeo Pocket Color',
      );
    case BrandLogoName.nes:
      return const BrandLogo(
        logo: NesControllLogo(),
        logoName: 'Nintendo Entertainment System',
      );
    case BrandLogoName.nintendo:
      return const BrandLogo(
        logo: NintendoLogo(),
        logoName: 'Nintendo',
      );
    case BrandLogoName.psOne:
      return const BrandLogo(
        logo: PsOneLogo(),
        logoName: 'PlayStation One',
      );
    case BrandLogoName.psVita:
      return const BrandLogo(
        logo: PsVitaLogo(),
        logoName: 'PlayStation Vita',
      );
    case BrandLogoName.ps2:
      return const BrandLogo(
        logo: Ps2Logo(),
        logoName: 'PlayStation 2',
      );
    case BrandLogoName.psp:
      return const BrandLogo(
        logo: PspLogo(),
        logoName: 'PlayStation Portable',
      );
    case BrandLogoName.retroArch:
      return const BrandLogo(
        logo: RetroArchLogo(),
        logoName: 'Retroarch',
      );
    case BrandLogoName.segaGenesis:
      return const BrandLogo(
        logo: SegaGenesisLogo(),
        logoName: 'Sega Genesis',
      );
    case BrandLogoName.sega:
      return const BrandLogo(
        logo: SegaLogo(),
        logoName: 'Sega',
      );

    case BrandLogoName.switchLogo:
      return const BrandLogo(
        logo: SwitchLogo(),
        logoName: 'Nintendo Switch',
      );
    default:
      throw Exception('Logo não encontrado para o nome especificado.');
  }
}

class BrandIcon extends StatelessWidget {
  final BrandLogoName logoName;
  const BrandIcon({
    super.key,
    required this.logoName,
  });

  @override
  Widget build(BuildContext context) {
    return getBrandLogo(logoName).logo;
  }
}
