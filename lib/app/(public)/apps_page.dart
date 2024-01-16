import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yuno/app/interactor/actions/apps_action.dart';
import 'package:yuno/app/interactor/atoms/gamepad_atom.dart';

import '../interactor/atoms/app_atom.dart';
import '../interactor/atoms/config_atom.dart';
import '../interactor/services/gamepad_service.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> with WidgetsBindingObserver {
  late RxDisposer _disposer;

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchApps();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchApps();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const itemWidth = 100.0;
    const padding = 17.0;
    var crossAxisCount = ((size.width - (padding * 2)) / itemWidth).floor();
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

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    openApp(app);
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
              );
            },
          ),
        );
      },
    );
  }
}
