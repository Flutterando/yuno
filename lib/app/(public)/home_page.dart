import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:routefly/routefly.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/atoms/game_atom.dart';
import 'package:yuno/app/interactor/models/game.dart';
import 'package:yuno/routes.dart';

import '../core/assets/sounds.dart' as sounds;
import '../core/widgets/animated_menu_leading.dart';
import '../core/widgets/animated_search.dart';
import '../core/widgets/animated_title_app_bart.dart';
import '../core/widgets/background/background.dart';
import '../core/widgets/card_tile/card_tile.dart';
import '../core/widgets/command_bar.dart';
import '../interactor/atoms/gamepad_atom.dart';
import '../interactor/services/gamepad_service.dart';

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
  var title = 'Home';
  final scrollController = AutoScrollController();
  final menuScrollController = AutoScrollController();

  List<Game> get games => filteredGamesState;
  DateTime? _lastOpenGameAt;
  var hasRailsExtanded = false;
  Timer? _timer;
  ColorScheme? newColorScheme;
  Brightness? newBrightness;

  late RxDisposer _disposer;

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
    if (Routefly.currentOriginalPath != routePaths.home || event == null) {
      return;
    }

    switch (event) {
      case GamepadButton.dpadDown || GamepadButton.leftStickDown:
        handlerSelect((selectedItemIndex + crossAxisCount) % games.length);
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

  void abxy(GamepadButton event) {
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

  void favorite() {}

  void resetConfig() {
    setState(() {
      title = 'Home';
      newColorScheme = null;
      selectedItemIndex = -1;
    });
  }

  void openSettings() {
    resetConfig();
    Routefly.push(routePaths.config);
  }

  void openApps() async {
    resetConfig();
    Routefly.push(routePaths.apps);
  }

  void switchRail() {
    sounds.openRail();
    setState(() {
      hasRailsExtanded = !hasRailsExtanded;
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
    title = 'Home';
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
      final railsMinWidth = hasRailsExtanded ? 256.0 : 72.0;

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
                  isCloseMenu: hasRailsExtanded,
                  icon: AnimatedIcons.menu_close,
                ),
                onPressed: switchRail,
              ),
              title: title,
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
                      extended: hasRailsExtanded,
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
                              child: SvgPicture.asset(
                                availableCategoriesState[i].image,
                                width: 28,
                              ),
                            ),
                            label: Text(availableCategoriesState[i].name),
                          ),
                      ],
                      selectedIndex: selectedDestinationIndex,
                    ),
                  ),
                ),
                if (games.isEmpty)
                  Expanded(
                    child: Center(
                      child: Container(
                        height: 90,
                        width: 220,
                        alignment: Alignment.center,
                        color: colorScheme.surfaceVariant.withOpacity(0.5),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('No games found'),
                            Gap(3),
                            Icon(Icons.gamepad_outlined),
                          ],
                        ),
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
                        childAspectRatio: 3 / 5,
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
                              if (index == selectedItemIndex) {
                                openGame();
                              } else {
                                handlerSelect(index);
                              }
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
              onApps: openApps,
              onSettings: openSettings,
              onFavorite: () {
                debugPrint('onFavorite');
              },
              onPlay: openGame,
            ),
          ),
        ],
      );
    });
  }
}
