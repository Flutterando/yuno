import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uno/uno.dart';
import 'package:yuno/app/interactor/models/game.dart';
import 'package:yuno/app/interactor/models/platforms/aethersx2.dart';
import 'package:yuno/app/interactor/models/platforms/android.dart';

import '../../interactor/atoms/game_atom.dart';
import '../../interactor/models/platforms/yuzu.dart';
import '../../interactor/repositories/game_repository.dart';

class MockGameRepository implements GameRepository {
  final uno = Uno();

  @override
  Future<List<Game>> getGames() async {
    return [
      Game(
        id: '1',
        name: 'Super Mario Odyssey',
        description: 'Super Mario Odyssey',
        platform: Yuzu(),
        image: await cacheImage(
            'https://cgngamesbh.com.br/product_images/p/512/Mario_Odyssey_Switch__68057_zoom.jpg'),
        path: 'caminho_do_jogo',
        category: {
          defaultCategoryAllState,
          defaultCategoryFavorite,
          categorieState.firstWhere((e) => e.name == "Nintendo Switch"),
        },
        genre: 'Platform',
        publisher: 'Nintendo',
      ),
      Game(
        id: '2',
        name: 'Dave the diver',
        description: 'Dave to Diver',
        platform: Yuzu(),
        image: await cacheImage(
            'https://images.nintendolife.com/08ce0f98414a5/dave-the-diver-cover.cover_large.jpg'),
        path: 'caminho_do_jogo',
        category: {
          defaultCategoryAllState,
          categorieState.firstWhere((e) => e.name == "Nintendo Switch"),
        },
        genre: 'Platform',
        publisher: 'Nintendo',
      ),
      Game(
        id: '3',
        name: 'Prince of Persia - The Sands of Time',
        description: 'Prince game',
        platform: AetherSX2(),
        image: await cacheImage(
            'https://upload.wikimedia.org/wikipedia/pt/thumb/8/85/Prince-of-Persia-The-Sands-of-Time-Cover.jpg/250px-Prince-of-Persia-The-Sands-of-Time-Cover.jpg'),
        path: 'caminho_do_jogo',
        category: {
          defaultCategoryAllState,
          categorieState.firstWhere((e) => e.name == "Playstation 2"),
        },
        genre: 'Platform',
        publisher: 'Nintendo',
      ),
      Game(
        id: '4',
        name: 'Dead Cells',
        description: 'Dead game',
        platform: Android(),
        image: '',
        path: 'caminho_do_jogo',
        category: {
          defaultCategoryAllState,
          categorieState.firstWhere((e) => e.name == "Android"),
        },
        genre: 'Platform',
        publisher: 'Nintendo',
      ),
      Game(
        id: '5',
        name: 'GTA Vice City',
        description: 'GTA Vice City',
        platform: Yuzu(),
        image: '',
        path: 'caminho_do_jogo',
        category: {
          defaultCategoryAllState,
          categorieState.firstWhere((e) => e.name == "Android"),
        },
        genre: 'Sandbox',
        publisher: 'Rockstar',
      ),
      Game(
        id: '6',
        name: 'GTA San Andreas',
        description: 'GTA San Andreas',
        platform: Yuzu(),
        image: '',
        path: 'caminho_do_jogo',
        category: {
          defaultCategoryAllState,
          categorieState.firstWhere((e) => e.name == "Android"),
        },
        genre: 'Sandbox',
        publisher: 'Rockstar',
      ),
    ];
  }

  Future<String> cacheImage(String imageUrl) async {
    final directory = await path_provider.getApplicationDocumentsDirectory();

    final name = basename(imageUrl);

    final file = File('${directory.path}/images/$name');

    if (!file.existsSync()) {
      await file.create(recursive: true);
      final response =
          await uno.get(imageUrl, responseType: ResponseType.arraybuffer);
      await file.writeAsBytes(response.data);
    }

    return file.path;
  }

  String basename(String path) {
    final parts = path.split('/');
    return parts.last;
  }
}
