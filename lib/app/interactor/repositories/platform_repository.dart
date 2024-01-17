import 'package:yuno/app/interactor/models/platform_model.dart';

import '../dtos/create_platform.dart';

abstract class PlatformRepository {
  Future<List<PlatformModel>> fetchPlatforms();

  Future<void> createPlatform(CreatePlatform platform);

  Future<void> updatePlatform(PlatformModel platform);

  Future<void> deletePlatform(PlatformModel platform);

  Future<void> syncPlatform(PlatformModel platform);
}
