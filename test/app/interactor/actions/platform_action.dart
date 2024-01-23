import 'package:flutter_test/flutter_test.dart';
import 'package:yuno/app/interactor/actions/platform_action.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';

void main() {
  test('Uri to path', () {
    expect(
      convertContentUriToFilePath(
          'content://com.android.externalstorage.documents/tree/primary%3AEmulation%2Frooms%2Fsnes/document/primary%3AEmulation%2Frooms%2Fsnes'),
      '/storage/emulated/0/Emulation/rooms/snes',
    );
  });

  test('clean name', () {
    final megaman = cleanName('Mega Man Zero 3.zip');
    expect(megaman, 'Mega Man Zero 3');
  });

  test('Sync games add', () {
    final currentGames = [
      Game(
        name: 'game 1',
        description: 'aaa',
        image: '',
        path: '/path1',
      ),
      Game(
        name: 'game 2',
        description: 'aaa',
        image: '',
        path: '/path2',
      ),
    ];
    final folderGames = [
      Game(
        name: 'game 1',
        description: '',
        image: '',
        path: '/path1',
      ),
      Game(
        name: 'game 2',
        description: '',
        image: '',
        path: '/path2',
      ),
      Game(
        name: 'game 3',
        description: '',
        image: '',
        path: '/path3',
      ),
    ];

    final games = syncGames(currentGames, folderGames);
    expect(games.length, 3);
    expect(games[0].description, 'aaa');
    expect(games[1].description, 'aaa');
  });

  test('Sync games remove', () {
    final currentGames = [
      Game(
        name: 'game 1',
        description: 'aaa',
        image: '',
        path: '/path1',
      ),
      Game(
        name: 'game 2',
        description: 'aaa',
        image: '',
        path: '/path2',
      ),
    ];
    final folderGames = [
      Game(
        name: 'game 1',
        description: '',
        image: '',
        path: '/path1',
      ),
      Game(
        name: 'game 3',
        description: '',
        image: '',
        path: '/path3',
      ),
    ];

    final games = syncGames(currentGames, folderGames);
    expect(games.length, 2);
    expect(games[0].description, 'aaa');
    expect(games[1].description, '');
    expect(games[1].name, 'game 3');
  });
}
