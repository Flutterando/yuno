import 'package:yuno/app/interactor/dtos/create_platform.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';

import '../../../interactor/repositories/platform_repository.dart';

class IsarPlatformRepository extends PlatformRepository {
  @override
  Future<void> createPlatform(CreatePlatform platform) {
    // TODO: implement createPlatform
    throw UnimplementedError();
  }

  @override
  Future<void> deletePlatform(PlatformModel platform) {
    // TODO: implement deletePlatform
    throw UnimplementedError();
  }

  @override
  Future<List<PlatformModel>> fetchPlatforms() async {
    return [];
  }

  @override
  Future<void> syncPlatform(PlatformModel platform) {
    // TODO: implement syncPlatform
    throw UnimplementedError();
  }

  @override
  Future<void> updatePlatform(PlatformModel platform) {
    // TODO: implement updatePlatform
    throw UnimplementedError();
  }
}
