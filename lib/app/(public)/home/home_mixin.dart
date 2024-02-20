import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:routefly/routefly.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';

import '../../../routes.dart';
import '../../core/widgets/card_tile/card_tile.dart';
import '../../core/widgets/player_select.dart';
import '../../interactor/actions/game_action.dart';
import '../../interactor/actions/platform_action.dart';
import '../../interactor/actions/sound_action.dart';
import '../../interactor/atoms/config_atom.dart';
import '../../interactor/atoms/game_atom.dart';
import '../../interactor/atoms/gamepad_atom.dart';
import '../../interactor/models/embeds/game.dart';
import '../../interactor/models/game_config.dart';
import '../../interactor/repositories/sound_repository.dart';
import '../../interactor/services/gamepad_service.dart';

abstract class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  Animation<double> get transitionAnimation;
}

mixin HomeMixin<T extends HomeWidget> on State<T> {
  var selectedItemIndex = 0;
  var crossAxisCount = 0;
  final scrollController = AutoScrollController();
  final menuScrollController = AutoScrollController();
  String? title;
  DateTime? _lastOpenGameAt;

  List<Game> get games => filteredGamesState;

  Timer? _timer;
  ColorScheme? newColorScheme;
  Brightness? newBrightness;

  late RxDisposer _disposer;

  BuildContext? _dialogContext;

  bool allowPressed() {
    return _lastOpenGameAt == null || //
        DateTime.now().difference(_lastOpenGameAt!).inSeconds > 1;
  }

  @override
  void initState() {
    super.initState();
    _disposer = rxObserver(() => gamepadState.value, effect: handleKey);
  }

  bool handleKey(GamepadButton? event) {
    if (!Routefly.currentOriginalPath.startsWith(routePaths.home.path) ||
        event == null ||
        _dialogContext?.mounted == true) {
      return false;
    }

    if (event == GamepadButton.start) {
      gameView();
    }

    return true;
  }

  void bayx(GamepadButton event) {
    switch (event) {
      case GamepadButton.buttonA:
        openGame();
      case GamepadButton.buttonB:
        openApps();
      case GamepadButton.buttonX:
        favorite();
      case GamepadButton.buttonY:
        openSettings();
      default:
    }
  }

  void abxy(GamepadButton event) {
    switch (event) {
      case GamepadButton.buttonA:
        openApps();
      case GamepadButton.buttonB:
        openGame();
      case GamepadButton.buttonX:
        openSettings();
      case GamepadButton.buttonY:
        favorite();
      default:
    }
  }

  void gameView() {
    final index = GameViewType.values.indexOf(gameConfigState.value.gameView);
    final nextIndex = (index + 1) % GameViewType.values.length;
    gameViewChange(GameViewType.values[nextIndex]);
  }

  void gameViewChange(GameViewType gameView) async {
    await saveConfig(gameConfigState.value.copyWith(gameView: gameView));
    if (GameViewType.list == gameView) {
      Routefly.navigate(routePaths.home.list);
    } else {
      Routefly.navigate(routePaths.home.grid);
    }
  }

  void favorite() {
    if (selectedItemIndex == -1) {
      return;
    }

    final game = games[selectedItemIndex];
    final newGame = game.copyWith(
      isFavorite: !game.isFavorite,
    );
    updateGame(game, newGame);
  }

  void resetConfig() {
    setState(() {
      title = null;
      newColorScheme = null;
      selectedItemIndex = 0;
    });
  }

  void openSettings() {
    resetConfig();
    Routefly.push(routePaths.config.path);
  }

  void openApps() async {
    resetConfig();
    Routefly.push(routePaths.apps);
  }

  void openGame() {
    if (!allowPressed()) {
      return;
    }
    if (selectedItemIndex < 0 || selectedItemIndex >= games.length) {
      return;
    }
    _lastOpenGameAt = DateTime.now();
    playSound(SoundAssets.enter);
    openGameWithPlayer(games[selectedItemIndex]);
  }

  Future<void> changeTitle() async {
    final game = games[selectedItemIndex];
    var newTitle = game.name;
    await showDialog<String>(
      context: context,
      builder: (context) {
        _dialogContext = context;
        return AlertDialog(
          title: Text('change_title'.i18n()),
          content: TextFormField(
            initialValue: game.name,
            onChanged: (value) {
              newTitle = value;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'title'.i18n(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel'.i18n()),
            ),
            TextButton(
              onPressed: () {
                if (newTitle.isEmpty) {
                  return;
                }
                updateGame(
                  game,
                  game.copyWith(name: newTitle),
                );
                Navigator.pop(context);
                setState(() {
                  title = newTitle;
                });
              },
              child: Text('ok'.i18n()),
            ),
          ],
        );
      },
    );
  }

  Future<void> changeCover() async {
    await showDialog<String>(
      context: context,
      builder: (_) {
        return RxBuilder(builder: (context) {
          _dialogContext = context;

          final game = games[selectedItemIndex];
          return AlertDialog(
            title: Text('change_cover'.i18n()),
            content: Align(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                //height: 250,
                //width: 188,
                child: Hero(
                  tag: game.name,
                  child: CardTile(
                    game: game,
                    colorSelect: Colors.transparent,
                    transitionAnimation: widget.transitionAnimation,
                    selected: true,
                    onTap: () {},
                    onLongPressed: () {},
                    index: 0,
                    gamesLength: 1,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  updateGame(game, game.copyWith(image: '', isSynced: false));
                  Navigator.pop(context);
                },
                child: Text('remove'.i18n()),
              ),
              TextButton(
                onPressed: () {
                  selectCover(game);
                },
                child: Text('select'.i18n()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ok'.i18n()),
              ),
            ],
          );
        });
      },
    );
  }

  void handlerDestinationSelect(int index) {
    if (!allowPressed()) {
      return;
    }
    playSound(SoundAssets.double);

    if (index < 0 || index >= availableCategoriesState.length) {
      return;
    }
    title = null;
    newColorScheme = null;
    selectedItemIndex = 0;
    gamesCategoryState.value = availableCategoriesState[index];
    menuScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  void handlerSelect(int index) {
    if (!allowPressed()) {
      return;
    }
    if (selectedItemIndex == index) {
      return;
    }

    playSound(SoundAssets.click);
    setState(() {
      selectedItemIndex = index;
    });
    final game = games[index];
    harmonize(game);
    scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  void harmonize(Game game) {
    if (newBrightness == null) {
      return;
    }

    _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 500), () {
      if (game.image.isEmpty || game.imageColor == null) {
        newColorScheme = null;
      } else {
        newColorScheme = ColorScheme.fromSeed(
          seedColor: game.imageColor!,
          brightness: newBrightness!,
        );
      }

      setState(() {
        title = game.name;
      });
    });
  }

  Future<void> resync() async {
    final game = games[selectedItemIndex];
    final platform = await updateGame(game, game.copyWith(isSynced: false));
    await syncPlatform(platform);
  }

  Future<void> overridePlatform() async {
    showDialog(
      context: context,
      builder: (context) {
        _dialogContext = context;
        return RxBuilder(builder: (context) {
          final game = games[selectedItemIndex];
          final overradedPlayer = game.overradedPlayer;
          return AlertDialog(
            title: Text('replace_player'.i18n()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(10),
                PlayerSelect(
                  player: overradedPlayer,
                  onChanged: (player) {
                    updateGame(game, game.copyWith(overradedPlayer: player));
                  },
                ),
                const Gap(10),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  updateGame(game, game.removeOverridedPlayer());
                },
                child: Text('remove'.i18n()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ok'.i18n()),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> gameMenu() async {
    final game = games[selectedItemIndex];
    showDialog(
      context: context,
      builder: (context) {
        _dialogContext = context;
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Text('play'.i18n()),
                  onTap: () {
                    openGame();
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text('change_title'.i18n()),
                  onTap: () {
                    Navigator.pop(context);
                    changeTitle();
                  }),
              ListTile(
                  title: Text('change_cover'.i18n()),
                  onTap: () {
                    Navigator.pop(context);
                    changeCover();
                  }),
              ListTile(
                title: Text('resync'.i18n()),
                onTap: () {
                  Navigator.pop(context);
                  resync();
                },
              ),
              if (getPlatformFromGame(game).category.id != 'android')
                ListTile(
                  title: Text('replace_player'.i18n()),
                  onTap: () {
                    Navigator.pop(context);
                    overridePlatform();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    menuScrollController.dispose();
    _disposer();
    super.dispose();
  }
}
