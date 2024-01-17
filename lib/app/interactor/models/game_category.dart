// ignore_for_file: public_member_api_docs, sort_constructors_first

class GameCategory {
  final String id;
  final String name;
  final String image;

  GameCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  bool operator ==(covariant GameCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
