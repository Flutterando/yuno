// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

class GameCategory {
  final String id;
  final String name;
  final String image;
  final List<String> extensions;

  GameCategory({
    required this.id,
    required this.name,
    required this.image,
    this.extensions = const [],
  });

  bool checkFileExtension(File element) => true;

  @override
  bool operator ==(covariant GameCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
