// import 'dart:io';
//
// import 'package:yuno/app/interactor/atoms/app_atom.dart';
// import 'package:yuno/app/interactor/dtos/create_platform.dart';
// import 'package:yuno/app/interactor/models/platform_model.dart';
//
// import '../../../interactor/atoms/game_atom.dart';
// import '../../../interactor/models/embeds/player.dart';
// import '../../../interactor/repositories/platform_repository.dart';
//
// class MockPlatformRepository extends PlatformRepository {
//   @override
//   Future<void> createPlatform(CreatePlatform platform) {
//     // TODO: implement createPlatform
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> deletePlatform(PlatformModel platform) {
//     // TODO: implement deletePlatform
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<List<PlatformModel>> fetchPlatforms() async {
//     await appsState.next();
//
//     return [
//       PlatformModel(
//         id: 1,
//         folder: Directory('/path/1'),
//         lastUpdate: DateTime.now(),
//         player: Player(
//           app: appsState.value.elementAt(0),
//         ),
//         category: categorieState.firstWhere((e) => e.id == "switch"),
//       ),
//       PlatformModel(
//         id: 2,
//         folder: Directory('/path/2'),
//         player: Player(
//           app: appsState.value.elementAt(0),
//         ),
//         lastUpdate: DateTime.now(),
//         category: categorieState.firstWhere((e) => e.id == "android"),
//       ),
//       PlatformModel(
//         id: 3,
//         folder: Directory('/path/3'),
//         player: Player(
//           app: appsState.value.elementAt(0),
//         ),
//         lastUpdate: DateTime.now(),
//         category: categorieState.firstWhere((e) => e.id == "ps2"),
//       )
//     ];
//   }
//
//   @override
//   Future<void> syncPlatform(PlatformModel platform) {
//     // TODO: implement syncPlatform
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> updatePlatform(PlatformModel platform) {
//     // TODO: implement updatePlatform
//     throw UnimplementedError();
//   }
// }
