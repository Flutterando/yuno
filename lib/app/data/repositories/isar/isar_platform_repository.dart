import 'package:isar/isar.dart';
import 'package:yuno/app/data/repositories/isar/db/platform_data.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';

import '../../../interactor/repositories/platform_repository.dart';
import 'adapters/platform_adapter.dart';
import 'isar_datasource.dart';

class IsarPlatformRepository extends PlatformRepository {
  @override
  Future<List<PlatformModel>> fetchPlatforms() async {
    final datas = await IsarDatasource.isar.platformDatas
        .where()
        .sortByCategory()
        .findAll();
    return datas.map((e) => PlatformAdapter.platformFromData(e)).toList();
  }

  @override
  Future<void> createPlatform(PlatformModel platform) async {
    final data = PlatformAdapter.platformFromModel(platform);
    await IsarDatasource.isar.writeTxn(() async {
      await IsarDatasource.isar.platformDatas.put(data); // insert & update
    });
  }

  @override
  Future<void> deletePlatform(PlatformModel platform) async {
    await IsarDatasource.isar.writeTxn(() async {
      await IsarDatasource.isar.platformDatas.delete(platform.id);
    });
  }

  @override
  Future<void> updatePlatform(PlatformModel platform) async {
    final data = PlatformAdapter.platformFromModel(platform);
    await IsarDatasource.isar.writeTxn(() async {
      await IsarDatasource.isar.platformDatas.put(data); // insert & update
    });
  }
}
