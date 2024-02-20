import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/interactor/actions/sound_action.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/app/interactor/atoms/game_atom.dart';
import 'package:yuno/app/interactor/repositories/sound_repository.dart';

import '../../core/widgets/animated_menu_leading.dart';
import '../../core/widgets/animated_search.dart';
import '../../core/widgets/animated_title_app_bart.dart';
import '../../core/widgets/background/background.dart';
import '../../core/widgets/card_tile/card_tile.dart';
import '../../core/widgets/category_image_widget.dart';
import '../../core/widgets/command_bar.dart';
import '../../core/widgets/no_items_widget.dart';
import '../../interactor/atoms/platform_atom.dart';
import '../../interactor/services/gamepad_service.dart';
import 'home_mixin.dart';

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

class HomePage extends HomeWidget {
  @override
  final Animation<double> transitionAnimation;

  const HomePage({super.key, required this.transitionAnimation});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  var hasRailsExtended = false;

  @override
  bool handleKey(GamepadButton? event) {
    if (!super.handleKey(event) || event == null) {
      return false;
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
        handlerDestinationSelect(availableCategoriesState //
                .indexOf(gamesCategoryState.value) -
            1);
      case GamepadButton.RB:
        handlerDestinationSelect(availableCategoriesState //
                .indexOf(gamesCategoryState.value) +
            1);
      case GamepadButton.select:
        switchRail();
      default:
        if (gameConfigState.value.swapABXY) {
          abxy(event);
        } else {
          bayx(event);
        }
    }
    return true;
  }

  void switchRail() {
    playSound(SoundAssets.openRail);
    setState(() {
      hasRailsExtended = !hasRailsExtended;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
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

        final index =
            availableCategoriesState.indexOf(gamesCategoryState.value);
        final selectedDestinationIndex = index >= 0 ? index : 0;

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
                  if (availableCategoriesState.length > 1)
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
                                  child: CategoryImageWidget(
                                    image: availableCategoriesState[i].image,
                                    size: 28,
                                  ),
                                ),
                                label:
                                    Text(availableCategoriesState[i].shortName),
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
                onGameView: gameView,
              ),
            ),
          ],
        );
      },
    );
  }
}
