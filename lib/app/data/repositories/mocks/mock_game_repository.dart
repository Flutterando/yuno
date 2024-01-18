// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:uno/uno.dart';
// import 'package:yuno/app/interactor/atoms/game_atom.dart';
// import 'package:yuno/app/interactor/models/app_model.dart';
// import 'package:yuno/app/interactor/models/embeds/game.dart';
// import 'package:yuno/app/interactor/models/embeds/player.dart';
// import 'package:yuno/app/interactor/repositories/game_repository.dart';
//
// import '../../../interactor/models/platform_model.dart';
//
// class MockGameRepository implements GameRepository {
//   final uno = Uno();
//
//   @override
//   Future<List<Game>> getGames() async {
//     return [
//       Game(
//         id: 1,
//         name: 'Super Mario Odyssey',
//         description: 'Super Mario Odyssey',
//         platform: PlatformModel(
//           id: 1,
//           folder: Directory(''),
//           lastUpdate: DateTime.now(),
//           category: categorieState.firstWhere((e) => e.id == "switch"),
//           player: Player(
//             app: AppModel(
//               name: 'Yuzu',
//               package: 'com.yuzu.android',
//               icon: Uint8List(0),
//             ),
//           ),
//         ),
//         image: await cacheImage(
//             'https://cgngamesbh.com.br/product_images/p/512/Mario_Odyssey_Switch__68057_zoom.jpg'),
//         imageColor: Colors.red,
//         path: 'caminho_do_jogo',
//         categories: {
//           defaultCategoryAllState,
//           categorieState.firstWhere((e) => e.id == "switch"),
//         },
//         genre: 'Platform',
//         publisher: 'Nintendo',
//       ),
//       Game(
//         id: 2,
//         name: 'Dave the diver',
//         description: 'Dave to Diver',
//         imageColor: Colors.blue,
//         image: await cacheImage(
//             'https://images.nintendolife.com/08ce0f98414a5/dave-the-diver-cover.cover_large.jpg'),
//         path: 'caminho_do_jogo',
//         platform: PlatformModel(
//           id: 1,
//           folder: Directory(''),
//           lastUpdate: DateTime.now(),
//           category: categorieState.firstWhere((e) => e.id == "switch"),
//           player: Player(
//             app: AppModel(
//               name: 'Yuzu',
//               package: 'com.yuzu.android',
//               icon: Uint8List(0),
//             ),
//           ),
//         ),
//         categories: {
//           defaultCategoryAllState,
//           categorieState.firstWhere((e) => e.id == "switch"),
//         },
//         genre: 'Platform',
//         publisher: 'Nintendo',
//       ),
//       Game(
//         id: 3,
//         name: 'Prince of Persia - The Sands of Time',
//         description: 'Prince game',
//         imageColor: Colors.deepPurple,
//         image: await cacheImage(
//             'https://upload.wikimedia.org/wikipedia/pt/thumb/8/85/Prince-of-Persia-The-Sands-of-Time-Cover.jpg/250px-Prince-of-Persia-The-Sands-of-Time-Cover.jpg'),
//         path:
//             'content://com.android.externalstorage.documents/tree/primary%3AEmulation%2Frooms%2Fps2/document/primary%3AEmulation%2Frooms%2Fps2%2FPrince%20of%20Persia%20-%20The%20Sands%20of%20Time%20(USA)%20(En%2CFr%2CEs).iso',
//         categories: {
//           defaultCategoryAllState,
//           categorieState.firstWhere((e) => e.id == "ps2"),
//         },
//         genre: 'Platform',
//         publisher: 'Nintendo',
//         platform: PlatformModel(
//           id: 1,
//           folder: Directory(''),
//           lastUpdate: DateTime.now(),
//           category: categorieState.firstWhere((e) => e.id == "ps2"),
//           player: Player(
//             app: AppModel(
//               name: 'aethersx2',
//               package: 'xyz.aethersx2.android',
//               icon: Uint8List(0),
//             ),
//           ),
//         ),
//       ),
//       Game(
//         id: 4,
//         name: 'Dead Cells',
//         description: 'Dead game',
//         image: '',
//         path: 'caminho_do_jogo',
//         categories: {
//           defaultCategoryAllState,
//           categorieState.firstWhere((e) => e.id == "android"),
//         },
//         genre: 'Platform',
//         publisher: 'Nintendo',
//         platform: PlatformModel(
//           id: 1,
//           folder: Directory(''),
//           lastUpdate: DateTime.now(),
//           category: categorieState.firstWhere((e) => e.id == "android"),
//           player: Player(
//             app: AppModel(
//               name: 'Yuzu',
//               package: 'com.playdigious.deadcells.mobile',
//               icon: Uint8List(0),
//             ),
//           ),
//         ),
//       ),
//       Game(
//         id: 5,
//         name: 'GTA Vice City',
//         description: 'GTA Vice City',
//         image: '',
//         path: 'caminho_do_jogo',
//         categories: {
//           defaultCategoryAllState,
//           categorieState.firstWhere((e) => e.id == "android"),
//         },
//         genre: 'Sandbox',
//         publisher: 'Rockstar',
//         platform: PlatformModel(
//           id: 1,
//           folder: Directory(''),
//           lastUpdate: DateTime.now(),
//           category: categorieState.firstWhere((e) => e.id == "android"),
//           player: Player(
//             app: AppModel(
//               name: 'Yuzu',
//               package: 'com.playdigious.deadcells.mobile',
//               icon: Uint8List(0),
//             ),
//           ),
//         ),
//       ),
//       Game(
//         id: 6,
//         name: 'GTA San Andreas',
//         description: 'GTA San Andreas',
//         image: '',
//         path: 'caminho_do_jogo',
//         categories: {
//           defaultCategoryAllState,
//           categorieState.firstWhere((e) => e.id == "android"),
//         },
//         genre: 'Sandbox',
//         publisher: 'Rockstar',
//         platform: PlatformModel(
//           id: 1,
//           folder: Directory(''),
//           lastUpdate: DateTime.now(),
//           category: categorieState.firstWhere((e) => e.id == "android"),
//           player: Player(
//             app: AppModel(
//               name: 'Yuzu',
//               package: 'com.playdigious.deadcells.mobile',
//               icon: Uint8List(0),
//             ),
//           ),
//         ),
//       ),
//     ];
//   }
//
//   Future<String> cacheImage(String imageUrl) async {
//     final directory = await path_provider.getApplicationDocumentsDirectory();
//
//     final name = basename(imageUrl);
//
//     final file = File('${directory.path}/images/$name');
//
//     if (!file.existsSync()) {
//       await file.create(recursive: true);
//       final response =
//           await uno.get(imageUrl, responseType: ResponseType.arraybuffer);
//       await file.writeAsBytes(response.data);
//     }
//
//     return file.path;
//   }
//
//   String basename(String path) {
//     final parts = path.split('/');
//     return parts.last;
//   }
// }
