import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';
import 'package:yuno/injector.dart';

import '../../core/services/game_service.dart';
import '../../core/widgets/animated_title_app_bart.dart';
import 'widgets/about_widget.dart';
import 'widgets/feedback_widget.dart';
import 'widgets/platform_widget.dart';
import 'widgets/settings_widget.dart';

Route routeBuilder(BuildContext context, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, a1, a2) => ConfigPage(
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

class ConfigPage extends StatefulWidget {
  final Animation<double> transitionAnimation;

  const ConfigPage({super.key, required this.transitionAnimation});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late RxDisposer _disposer;

  var selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();

    final gamepadService = injector.get<GameService>();
    _disposer = rxObserver(() => gamepadService.state, effect: (state) {
      if (gameConfigState.value.swapABXY && state == GamepadButton.buttonA) {
        Navigator.of(context).pop();
      } else if (state == GamepadButton.buttonB) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnimatedTitleAppBar(
        title: 'Config',
      ),
      body: Row(
        children: [
          Stack(
            children: [
              NavigationRail(
                extended: true,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.gamepad),
                    label: Text('Platforms'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Preferences'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.chat_outlined),
                    label: Text('Feedback'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.info_outline),
                    label: Text('About'),
                  ),
                ],
                selectedIndex: selectedItemIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedItemIndex = index;
                  });
                },
              ),
              Positioned(
                bottom: 10,
                left: 18,
                right: 0,
                child: Text(buildNumberState.value),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: selectedItemIndex,
              children: [
                PlatformWidget(transitionAnimation: widget.transitionAnimation),
                const SettingsWidget(),
                FeedbackWidget(),
                AboutWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
