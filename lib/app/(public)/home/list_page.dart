import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:routefly/routefly.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/core/widgets/category_image_widget.dart';

import '../../../routes.dart';
import '../../core/widgets/animated_search.dart';
import '../../core/widgets/animated_tile.dart';
import '../../core/widgets/background/background.dart';
import '../../core/widgets/card_tile/card_tile.dart';
import '../../core/widgets/command_bar.dart';
import '../../core/widgets/no_items_widget.dart';
import '../../core/widgets/player_select.dart';
import '../../interactor/actions/game_action.dart';
import '../../interactor/actions/platform_action.dart';
import '../../interactor/actions/sound_action.dart';
import '../../interactor/atoms/config_atom.dart';
import '../../interactor/atoms/game_atom.dart';
import '../../interactor/atoms/gamepad_atom.dart';
import '../../interactor/atoms/platform_atom.dart';
import '../../interactor/models/embeds/game.dart';
import '../../interactor/repositories/sound_repository.dart';
import '../../interactor/services/gamepad_service.dart';

Route routeBuilder(BuildContext context, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(seconds: 2),
    pageBuilder: (_, a1, a2) => ListPage(
      transitionAnimation: a1,
    ),
    transitionsBuilder: (_, a1, a2, child) {
      final curved = CurvedAnimation(
        parent: a1,
        curve: const Interval(0.0, 0.5),
      );
      return FadeTransition(opacity: curved, child: child);
    },
  );
}

class ListPage extends StatefulWidget {
  final Animation<double> transitionAnimation;

  const ListPage({super.key, required this.transitionAnimation});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var selectedItemIndex = 0;
  var crossAxisCount = 0;
  String? title;
  final scrollController = AutoScrollController();
  final menuScrollController = AutoScrollController();

  List<Game> get games => filteredGamesState;
  DateTime? _lastOpenGameAt;
  var hasRailsExtended = false;
  Timer? _timer;
  ColorScheme? newColorScheme;
  Brightness? newBrightness;

  late RxDisposer _disposer;

  BuildContext? _dialogContext;

  @override
  void initState() {
    super.initState();
    _disposer = rxObserver(() => gamepadState.value, effect: handleKey);
  }

  bool allowPressed() {
    return _lastOpenGameAt == null || //
        DateTime.now().difference(_lastOpenGameAt!).inSeconds > 1;
  }

  void handleKey(GamepadButton? event) {
    if (Routefly.currentOriginalPath != routePaths.home.list ||
        event == null ||
        _dialogContext?.mounted == true) {
      return;
    }

    switch (event) {
      case GamepadButton.dpadDown || GamepadButton.leftStickDown:
        handlerSelect((selectedItemIndex + 1) < games.length
            ? selectedItemIndex + 1
            : selectedItemIndex);
      case GamepadButton.dpadUp || GamepadButton.leftStickUp:
        handlerSelect((selectedItemIndex - 1) >= 0
            ? selectedItemIndex - 1
            : selectedItemIndex);
      case GamepadButton.LB:
        handlerDestinationSelect(availableCategoriesState //
                .indexOf(gamesCategoryState.value) -
            1);
      case GamepadButton.RB:
        handlerDestinationSelect(availableCategoriesState //
                .indexOf(gamesCategoryState.value) +
            1);
      case GamepadButton.start:
      case GamepadButton.select:
        switchRail();
      default:
        if (gameConfigState.value.swapABXY) {
          abxy(event);
        } else {
          bayx(event);
        }
    }
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

  void switchRail() {
    playSound(SoundAssets.openRail);
    setState(() {
      hasRailsExtended = !hasRailsExtended;
    });
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RxBuilder(builder: (context) {
      newBrightness = theme.brightness;
      final config = gameConfigState.value;

      final colorScheme = newColorScheme ?? theme.colorScheme;

      final selectedGame = games.isNotEmpty ? games[selectedItemIndex] : null;

      return Stack(
        children: [
          Container(
            color: colorScheme.background,
          ),
          Background(
            type: config.backgroundType,
            color: colorScheme.primaryContainer,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Row(
                children: [
                  const Gap(16),
                  Text(
                    'YuNO',
                    style: GoogleFonts.lemon(
                      fontSize: 24,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                ' L',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            ...availableCategoriesState.map(
                              (category) {
                                final index =
                                    availableCategoriesState.indexOf(category);
                                final selected =
                                    category.id == gamesCategoryState.value.id;
                                return AutoScrollTag(
                                  key: ValueKey(category.id),
                                  controller: menuScrollController,
                                  index: index,
                                  child: IconButton(
                                    isSelected: category.id ==
                                        gamesCategoryState.value.id,
                                    onPressed: () {
                                      handlerDestinationSelect(index);
                                    },
                                    icon: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? colorScheme.surfaceVariant
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CategoryImageWidget(
                                        image: category.image,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'R ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  AnimatedSearch(
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),
            body: games.isEmpty
                ? Center(
                    child: NoItemWidget(
                      title: 'no_games_found'.i18n(),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 12, bottom: 200),
                          controller: scrollController,
                          itemCount: games.length,
                          itemBuilder: (context, index) {
                            final game = games[index];
                            final selected = selectedItemIndex == index;
                            return AutoScrollTag(
                              key: ValueKey(game.path),
                              controller: scrollController,
                              index: index,
                              child: AnimatedTile(
                                colorScheme: colorScheme,
                                selected: selected,
                                text: game.name,
                                subtext:
                                    getPlatformFromGame(game).category.name,
                                onTap: () {
                                  handlerSelect(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: selectedGame == null
                              ? const SizedBox()
                              : CardTile(
                                  game: selectedGame,
                                  colorSelect: colorScheme.primary,
                                  transitionAnimation:
                                      widget.transitionAnimation,
                                  selected: false,
                                  onTap: () {},
                                  onLongPressed: () {},
                                  index: 0,
                                  gamesLength: games.length,
                                ),
                        ),
                      ),
                    ],
                  ),
            bottomNavigationBar: NavigationCommand(
              colorScheme: colorScheme,
              isSyncing: isPlatformSyncing,
              onApps: openApps,
              onSettings: openSettings,
              onFavorite: favorite,
              onPlay: openGame,
            ),
          ),
        ],
      );
    });
  }
}
