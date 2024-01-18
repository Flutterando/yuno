import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'db/platform_data.dart';

class IsarDatasource {
  static late final Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [PlatformDataSchema],
      directory: dir.path,
    );
  }
}
