import 'package:isar/isar.dart';
import 'package:yuno/app/data/repositories/isar/db/platform_data.dart';

part 'game_data.g.dart';

@collection
class GameData {
  Id id = Isar.autoIncrement;

  final platform = IsarLink<PlatformData>();
  final overradedPlatform = IsarLink<PlatformData>();
  late String name;
  late String description;
  String? image;
  String? imageColor;
  late String path;
  late List<String> categories;
  String? genre;
  String? publisher;
}
