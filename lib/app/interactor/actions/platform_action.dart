import 'package:yuno/app/interactor/dtos/create_platform.dart';
import 'package:yuno/app/interactor/models/platform_model.dart';
import 'package:yuno/app/interactor/repositories/platform_repository.dart';
import 'package:yuno/injector.dart';

import '../atoms/platform_atom.dart';

Future<void> fetchPlatforms() async {
  final repository = injector<PlatformRepository>();
  platformsState.value = await repository.fetchPlatforms();
}

Future<void> createPlatform(CreatePlatform platform) async {
  final repository = injector<PlatformRepository>();
  await repository.createPlatform(platform);
  await fetchPlatforms();
}

Future<void> updatePlatform(PlatformModel platform) async {
  final repository = injector<PlatformRepository>();
  await repository.updatePlatform(platform);
  await fetchPlatforms();
}

Future<void> deletePlatform(PlatformModel platform) async {
  final repository = injector<PlatformRepository>();
  await repository.deletePlatform(platform);
  await fetchPlatforms();
}

Future<void> syncPlatform(PlatformModel platform) async {
  final repository = injector<PlatformRepository>();
  await repository.syncPlatform(platform);
  await fetchPlatforms();
}
