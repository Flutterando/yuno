// ignore_for_file: public_member_api_docs, sort_constructors_first

class GameCategory {
  final String id;
  final String name;
  late final shortName;
  final String image;
  final List<String> extensions;

  GameCategory({
    required this.id,
    required this.name,
    required this.image,
    String? shortName,
    this.extensions = const [],
  }){
    this.shortName = shortName ?? name;
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
