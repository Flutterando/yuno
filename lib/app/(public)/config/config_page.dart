import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../core/widgets/animated_title_app_bart.dart';
import '../../interactor/atoms/config_atom.dart';
import '../../interactor/atoms/gamepad_atom.dart';
import '../../interactor/services/gamepad_service.dart';
import 'widgets/about_widget.dart';
import 'widgets/cover_settings_widget.dart';
import 'widgets/feedback_widget.dart';
import 'widgets/platform_widget.dart';
import 'widgets/preferences_widget.dart';

Route routeBuilder(BuildContext context, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, a1, a2) {
      return ConfigPage(
        transitionAnimation: a1,
      );
    },
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

    _disposer = rxObserver(() => gamepadState.value, effect: (state) {
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
    Localizations.localeOf(context);
    return Scaffold(
      appBar: AnimatedTitleAppBar(
        title: 'settings'.i18n(),
      ),
      body: Row(
        children: [
          Stack(
            children: [
              NavigationRail(
                extended: true,
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.gamepad),
                    label: Text('platforms'.i18n()),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.settings),
                    label: Text('preferences'.i18n()),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.image),
                    label: Text('cover'.i18n()),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.chat_outlined),
                    label: Text('feedback'.i18n()),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.info_outline),
                    label: Text('about'.i18n()),
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
                const PreferencesWidget(),
                const CoverSettingsWidget(),
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
