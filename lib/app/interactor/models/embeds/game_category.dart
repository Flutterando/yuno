// ignore_for_file: public_member_api_docs, sort_constructors_first

class GameCategory {
  final String id;
  final String name;
  final String shortName;
  final CategoryImage image;
  final List<String> extensions;

  const GameCategory({
    required this.id,
    required this.name,
    required this.image,
    String? shortName,
    this.extensions = const [],
  }) : shortName = shortName ?? name;

  factory GameCategory.unknown() {
    return const GameCategory(
      id: 'unknown',
      name: 'unknown',
      image: NoCategoryImage(),
      shortName: '',
    );
  }

  bool checkFileExtension(String name) {
    if (extensions.isEmpty) {
      return true;
    }
    return extensions //
        .any((extension) => name.toLowerCase().endsWith(extension));
  }

  @override
  bool operator ==(covariant GameCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}

abstract class CategoryImage {
  const CategoryImage();

  static CategoryImage fromSVG(String path) {
    return SVGCategoryImage(path);
  }

  static CategoryImage fromEmuIcon(icon) {
    return EmuIconsCategoryImage(icon);
  }
}

class SVGCategoryImage extends CategoryImage {
  final String path;

  const SVGCategoryImage(this.path);
}

class EmuIconsCategoryImage extends CategoryImage {
  final dynamic icon;

  const EmuIconsCategoryImage(this.icon);
}

class NoCategoryImage extends CategoryImage {
  const NoCategoryImage();
}
