import 'package:yuno/app/interactor/models/platform_model.dart';

abstract class PlatformRepository {
  Future<List<PlatformModel>> fetchPlatforms();

  Future<void> createPlatform(PlatformModel platform);

  Future<void> updatePlatform(PlatformModel platform);

  Future<void> deletePlatform(PlatformModel platform);
}
