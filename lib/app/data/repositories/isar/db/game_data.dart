import 'package:isar/isar.dart';

part 'game_data.g.dart';

@embedded
class GameData {
  String? overradedPlayer;
  late String name;
  late String description;
  String? image;
  String? imageColor;
  bool isSynced = false;
  bool isFavorite = false;
  late String path;
  String? genre;
  String? publisher;
}
