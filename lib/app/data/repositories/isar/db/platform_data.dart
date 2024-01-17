import 'package:isar/isar.dart';

part 'platform_data.g.dart';

@collection
class PlatformData {
  Id id = Isar.autoIncrement;
  late String category;
  late String playerPackageId;
  String? playerExtra;
  late String folder;
  late DateTime lastUpdate;
}
