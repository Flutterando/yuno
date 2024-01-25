import 'package:isar/isar.dart';

import 'game_data.dart';

part 'platform_data.g.dart';

@collection
class PlatformData {
  Id id = Isar.autoIncrement;
  late String category;
  String? playerPackageId;
  String? playerExtra;
  String? folderCover;
  late String folder;
  late DateTime lastUpdate;
  List<GameData> games = [];
}
