import 'package:emu_icons/brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuno/app/interactor/models/embeds/game_category.dart';

import '../assets/svgs.dart';

class CategoryImageWidget extends StatelessWidget {
  final CategoryImage image;
  final double size;

  const CategoryImageWidget({super.key, required this.image, this.size = 24});

  @override
  Widget build(BuildContext context) {
    final localImage = image;
    if (localImage is SVGCategoryImage) {
      return SvgPicture(
        getLoader(localImage.path),
        width: size,
      );
    }
    if (localImage is EmuIconsCategoryImage) {
      return SizedBox(
        width: size,
        height: size,
        child: BrandIcon(logoName: localImage.icon),
      );
    }

    return const SizedBox();
  }
}
