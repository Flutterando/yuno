import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/core/widgets/category_image_widget.dart';

import '../../core/widgets/animated_search.dart';
import '../../core/widgets/animated_tile.dart';
import '../../core/widgets/background/background.dart';
import '../../core/widgets/card_tile/card_tile.dart';
import '../../core/widgets/command_bar.dart';
import '../../core/widgets/no_items_widget.dart';
import '../../interactor/actions/game_action.dart';
import '../../interactor/atoms/config_atom.dart';
import '../../interactor/atoms/game_atom.dart';
import '../../interactor/atoms/platform_atom.dart';
import '../../interactor/services/gamepad_service.dart';
import 'home_mixin.dart';

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

class ListPage extends HomeWidget {
  @override
  final Animation<double> transitionAnimation;

  const ListPage({super.key, required this.transitionAnimation});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with HomeMixin {
  @override
  bool handleKey(GamepadButton? event) {
    if (!super.handleKey(event) || event == null) {
      return false;
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
      default:
        if (gameConfigState.value.swapABXY) {
          abxy(event);
        } else {
          bayx(event);
        }
    }
    return true;
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
                                index: index,
                                gamesLength: games.length,
                                transitionAnimation: widget.transitionAnimation,
                                colorScheme: colorScheme,
                                selected: selected,
                                text: game.name,
                                subtext:
                                    getPlatformFromGame(game).category.name,
                                onTap: () {
                                  handlerSelect(index);
                                  openGame();
                                },
                                onLongPressed: () {
                                  handlerSelect(index);
                                  gameMenu();
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
              onGameView: gameView,
            ),
          ),
        ],
      );
    });
  }
}
