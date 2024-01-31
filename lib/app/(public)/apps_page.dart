import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuno/app/interactor/actions/apps_action.dart';
import 'package:yuno/app/interactor/atoms/gamepad_atom.dart';

import '../interactor/actions/sound_action.dart';
import '../interactor/atoms/app_atom.dart';
import '../interactor/atoms/config_atom.dart';
import '../interactor/repositories/sound_repository.dart';
import '../interactor/services/gamepad_service.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  late RxDisposer _disposer;
  var selectedItemIndex = -1;
  var crossAxisCount = 2;
  final scrollController = AutoScrollController();

  @override
  void initState() {
    super.initState();
    _disposer = rxObserver(() => gamepadState.value, effect: handleKey);
  }

  void handleKey(GamepadButton? event) {
    switch (event) {
      case GamepadButton.dpadDown || GamepadButton.leftStickDown:
        handlerSelect(
            (selectedItemIndex + crossAxisCount) < appsState.value.length
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
        handlerSelect((selectedItemIndex + 1) % appsState.value.length);
      default:
        if (gameConfigState.value.swapABXY) {
          abxy(event);
        } else {
          bayx(event);
        }
    }
  }

  void bayx(GamepadButton? event) {
    switch (event) {
      case GamepadButton.buttonA:
        requestOpenApp();
      case GamepadButton.buttonB:
        Navigator.of(context).pop();
      default:
    }
  }

  void abxy(GamepadButton? event) {
    switch (event) {
      case GamepadButton.buttonA:
        Navigator.of(context).pop();
      case GamepadButton.buttonB:
        requestOpenApp();

      default:
    }
  }

  void handlerSelect(int index) {
    if (selectedItemIndex == index) {
      return;
    }

    playSound(SoundAssets.click);
    setState(() {
      selectedItemIndex = index;
    });
    scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  void requestOpenApp() {
    openApp(appsState.value.elementAt(selectedItemIndex));
    setState(() {
      selectedItemIndex = -1;
    });
  }

  @override
  void dispose() {
    _disposer();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    const itemWidth = 100.0;
    const padding = 17.0;
    crossAxisCount = ((size.width - (padding * 2)) / itemWidth).floor();
    if (crossAxisCount < 2) {
      crossAxisCount = 2;
    }

    return RxBuilder(
      builder: (_) {
        final apps = appsState.value;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Apps'),
            actions: const [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: openConfiguration,
              ),
            ],
          ),
          body: GridView.builder(
            addAutomaticKeepAlives: true,
            controller: scrollController,
            padding: const EdgeInsets.only(
              bottom: 12,
              left: padding,
              right: padding,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1 / 1,
            ),
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps.elementAt(index);

              return AutoScrollTag(
                key: Key('app_$index'),
                index: index,
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedItemIndex == index
                            ? theme.colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        selectedItemIndex = index;
                        requestOpenApp();
                      },
                      onLongPress: () {
                        openAppSettings(app);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(5),
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: Image.memory(
                              app.icon,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            app.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
