import 'dart:async';
import 'dart:ui';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/core/services/game_service.dart';
import 'package:yuno/app/core/widgets/animated_floating_action_button.dart';
import 'package:yuno/injector.dart';
import 'package:yuno/routes.dart';

import '../core/assets/sounds.dart' as sounds;
import '../core/assets/static.dart' as assets;
import '../core/widgets/animated_menu_leading.dart';
import '../core/widgets/animated_title_app_bart.dart';
import '../core/widgets/card_tile/card_tile.dart';

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
  final itemCount = 20;
  final scrollController = AutoScrollController();
  final menuScrollController = AutoScrollController();

  var hasRailsExtanded = false;
  Timer? _timer;

  late RxDisposer _disposer;

  @override
  void initState() {
    super.initState();
    final gamepadService = injector.get<GameService>();
    _disposer = rxObserver(() => gamepadService.state, effect: (state) {
      handleKey(state!);
    });
  }

  void handleKey(GamepadButton event) {
    switch (event) {
      case GamepadButton.dpadDown || GamepadButton.leftStickDown:
        handlerSelect((selectedItemIndex + crossAxisCount) % itemCount);
      case GamepadButton.dpadUp || GamepadButton.leftStickUp:
        handlerSelect((selectedItemIndex - crossAxisCount) >= 0 ? selectedItemIndex - crossAxisCount : selectedItemIndex);
      case GamepadButton.dpadLeft || GamepadButton.leftStickLeft:
        handlerSelect(selectedItemIndex > 0 ? selectedItemIndex - 1 : selectedItemIndex);
      case GamepadButton.dpadRight || GamepadButton.leftStickRight:
        handlerSelect((selectedItemIndex + 1) % itemCount);
      case GamepadButton.LB:
        handlerDestinationSelect((selectedDestinationIndex - 1) >= 0 ? selectedDestinationIndex - 1 : selectedDestinationIndex);
      case GamepadButton.RB:
        handlerDestinationSelect(selectedDestinationIndex + 1);
      case GamepadButton.select:
        setState(() {
          hasRailsExtanded = !hasRailsExtanded;
        });
      case GamepadButton.buttonA:
      case GamepadButton.buttonB:
      case GamepadButton.buttonX:
      case GamepadButton.buttonY:
      case GamepadButton.start:
      case GamepadButton.rightThumb:
      case GamepadButton.leftThumb:
    }
  }

  void handlerDestinationSelect(int index) {
    sounds.doubleSound();
    setState(() {
      selectedDestinationIndex = index;
    });
    menuScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  void handlerSelect(int index) {
    sounds.clickSound();
    setState(() {
      selectedItemIndex = index;
    });
    _updateTitle('Game ${index + 1}');
    scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
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
    var Size(:width) = MediaQuery.sizeOf(context);

    const itemWidth = 140.0;
    final railsMinWidth = hasRailsExtanded ? 256.0 : 72.0;

    final gridWidth = width - railsMinWidth;

    crossAxisCount = (gridWidth / itemWidth).floor();
    if (crossAxisCount < 2) {
      crossAxisCount = 2;
    }

    return FocusScope(
      canRequestFocus: false,
      child: Scaffold(
        appBar: AnimatedTitleAppBar(
          leading: IconButton(
            icon: AnimatedMenuLeading(
              isCloseMenu: hasRailsExtanded,
              icon: AnimatedIcons.menu_close,
            ),
            onPressed: () {
              setState(() {
                hasRailsExtanded = !hasRailsExtanded;
              });
            },
          ),
          title: title,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Routefly.push(routePaths.config);
              },
            ),
          ],
        ),
        body: Row(
          children: [
            SingleChildScrollView(
              controller: menuScrollController,
              child: IntrinsicHeight(
                child: NavigationRail(
                  extended: hasRailsExtanded,
                  destinations: [
                    NavigationRailDestination(
                      icon: AutoScrollTag(
                        controller: menuScrollController,
                        index: 0,
                        key: const ValueKey(0),
                        child: const Icon(Icons.all_inclusive_outlined),
                      ),
                      label: const Text('All'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.star),
                      label: Text('Android'),
                    ),
                    NavigationRailDestination(
                      icon: Image.asset(assets.switchPNG),
                      label: const Text('Nintendo Switch'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.all_inclusive_outlined),
                      label: Text('All'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.star),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.android, color: Colors.green),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.all_inclusive_outlined),
                      label: Text('All'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.star),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.android, color: Colors.green),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.all_inclusive_outlined),
                      label: Text('All'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.star),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.android, color: Colors.green),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.all_inclusive_outlined),
                      label: Text('All'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.star),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.android, color: Colors.green),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.all_inclusive_outlined),
                      label: Text('All'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.star),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.android, color: Colors.green),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.all_inclusive_outlined),
                      label: Text('All'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.star),
                      label: Text('Android'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.android, color: Colors.green),
                      label: Text('Android'),
                    ),
                  ],
                  selectedIndex: selectedDestinationIndex,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.only(bottom: 120),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 3 / 5,
                ),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  double start = index / itemCount;
                  double duration = 1 / itemCount;

                  final curved = CurvedAnimation(
                    parent: widget.transitionAnimation,
                    curve: const Interval(0.5, 1.0),
                  );

                  final animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
                    parent: curved,
                    curve: Interval(start, start + duration, curve: Curves.easeOut),
                  ));

                  return AutoScrollTag(
                    index: index,
                    key: ValueKey(index),
                    controller: scrollController,
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return Opacity(
                          opacity: lerpDouble(1.0, 0.0, animation.value)!,
                          child: Transform.translate(
                            offset: Offset(0, animation.value * 100),
                            child: CardTile(
                              selected: selectedItemIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedItemIndex = index;
                                });
                              },
                              title: 'Game ${index + 1}',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: AnimatedFloatingActionButton(
          onPressed: () async {},
          label: 'Add Game',
          icon: Icons.add,
          animation: widget.transitionAnimation,
        ),
      ),
    );
  }

  void _updateTitle(String newTitle) {
    _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        title = newTitle;
      });
    });
  }
}
