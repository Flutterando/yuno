import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:routefly/routefly.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/atoms/game_atom.dart';
import 'package:yuno/app/interactor/models/embeds/game.dart';
import 'package:yuno/routes.dart';

import '../core/assets/sounds.dart' as sounds;
import '../core/assets/svgs.dart';
import '../core/widgets/animated_menu_leading.dart';
import '../core/widgets/animated_search.dart';
import '../core/widgets/animated_title_app_bart.dart';
import '../core/widgets/background/background.dart';
import '../core/widgets/card_tile/card_tile.dart';
import '../core/widgets/command_bar.dart';
import '../core/widgets/no_items_widget.dart';
import '../interactor/actions/game_action.dart';
import '../interactor/actions/platform_action.dart';
import '../interactor/atoms/gamepad_atom.dart';
import '../interactor/atoms/platform_atom.dart';
import '../interactor/services/gamepad_service.dart';
import 'config/widgets/player_select.dart';

Route routeBuilder(BuildContext context, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(seconds: 2),
    pageBuilder: (_, a1, a2) => HomePage(
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

class HomePage extends StatefulWidget {
  final Animation<double> transitionAnimation;

  const HomePage({super.key, required this.transitionAnimation});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedItemIndex = -1;
  var selectedDestinationIndex = 0;
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
    if (Routefly.currentOriginalPath != routePaths.home ||
        event == null ||
        _dialogContext?.mounted == true) {
      return;
    }

    switch (event) {
      case GamepadButton.dpadDown || GamepadButton.leftStickDown:
        handlerSelect((selectedItemIndex + crossAxisCount) < games.length
            ? selectedItemIndex + crossAxisCount
            : selectedItemIndex);
      case GamepadButton.dpadUp || GamepadButton.leftStickUp:
        handlerSelect((selectedItemIndex - crossAxisCount) >= 0
            ? selectedItemIndex - crossAxisCount
            : selectedItemIndex);
      case GamepadButton.dpadLeft || GamepadButton.leftStickLeft:
        handlerSelect(
            selectedItemIndex > 0 ? selectedItemIndex - 1 : selectedItemIndex);
      case GamepadButton.dpadRight || GamepadButton.leftStickRight:
        handlerSelect((selectedItemIndex + 1) % games.length);
      case GamepadButton.LB:
        handlerDestinationSelect(selectedDestinationIndex - 1);
      case GamepadButton.RB:
        handlerDestinationSelect(selectedDestinationIndex + 1);
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
      selectedItemIndex = -1;
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
    sounds.openRail();
    setState(() {
      hasRailsExtended = !hasRailsExtended;
    });
  }

  void handlerDestinationSelect(int index) {
    if (!allowPressed()) {
      return;
    }
    sounds.doubleSound();

    if (index < 0 || index >= availableCategoriesState.length) {
      return;
    }
    selectedDestinationIndex = index;
    title = null;
    newColorScheme = null;
    selectedItemIndex = -1;
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

    sounds.clickSound();
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
    sounds.enterSound();
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
    return RxBuilder(builder: (context) {
      var Size(:width) = MediaQuery.sizeOf(context);

      final config = gameConfigState.value;

      const itemWidth = 140.0;
      final railsMinWidth = hasRailsExtended ? 256.0 : 72.0;

      final gridWidth = width - railsMinWidth;

      crossAxisCount = (gridWidth / itemWidth).floor();
      if (crossAxisCount < 2) {
        crossAxisCount = 2;
      }

      final theme = Theme.of(context);

      newBrightness = theme.brightness;

      final colorScheme = newColorScheme ?? theme.colorScheme;

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
            appBar: AnimatedTitleAppBar(
              surfaceTintColor: colorScheme.surfaceTint,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: AnimatedMenuLeading(
                  isCloseMenu: hasRailsExtended,
                  icon: AnimatedIcons.menu_close,
                ),
                onPressed: switchRail,
              ),
              title: title ?? 'home'.i18n(),
              actions: [
                AnimatedSearch(onChanged: (value) {
                  gameSearchState.value = value;
                }),
              ],
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  controller: menuScrollController,
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      backgroundColor: Colors.transparent,
                      indicatorColor: colorScheme.surfaceVariant,
                      extended: hasRailsExtended,
                      onDestinationSelected: (value) {
                        handlerDestinationSelect(value);
                      },
                      destinations: [
                        for (var i = 0;
                            i < availableCategoriesState.length;
                            i++)
                          NavigationRailDestination(
                            icon: AutoScrollTag(
                              controller: menuScrollController,
                              index: i,
                              key: ValueKey(i),
                              child: SvgPicture(
                                getLoader(availableCategoriesState[i].image),
                                width: 28,
                              ),
                            ),
                            label: Text(availableCategoriesState[i].shortName),
                          ),
                      ],
                      selectedIndex: selectedDestinationIndex,
                    ),
                  ),
                ),
                if (games.isEmpty)
                  Expanded(
                    child: Center(
                      child: NoItemWidget(
                        title: 'no_games_found'.i18n(),
                      ),
                    ),
                  ),
                if (games.isNotEmpty)
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.only(bottom: 120),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        return AutoScrollTag(
                          index: index,
                          key: ValueKey(index),
                          controller: scrollController,
                          child: CardTile(
                            game: games[index],
                            colorSelect: colorScheme.primary,
                            transitionAnimation: widget.transitionAnimation,
                            selected: selectedItemIndex == index,
                            onTap: () {
                              handlerSelect(index);
                              openGame();
                            },
                            onLongPressed: () {
                              handlerSelect(index);
                              gameMenu();
                            },
                            index: index,
                            gamesLength: games.length,
                          ),
                        );
                      },
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
