import 'dart:math';

import 'package:asp/asp.dart';
import 'package:based_battery_indicator/based_battery_indicator.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localization/localization.dart';
import 'package:yuno/app/core/widgets/animated_sync_button.dart';

import '../../interactor/atoms/config_atom.dart';

class NavigationCommand extends StatelessWidget {
  final VoidCallback? onApps;
  final VoidCallback? onPlay;
  final VoidCallback? onFavorite;
  final VoidCallback? onSettings;
  final VoidCallback? onGameView;
  final ColorScheme colorScheme;
  final bool isSyncing;

  const NavigationCommand({
    super.key,
    this.onApps,
    this.onFavorite,
    this.onGameView,
    this.onSettings,
    this.onPlay,
    this.isSyncing = false,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LabelButton(
            label: 'apps'.i18n(),
            buttonText: 'B',
            onTap: onApps,
            background: colorScheme.onBackground,
            textColor: colorScheme.background,
          ),
          const Gap(17),
          LabelButton(
            label: 'settings'.i18n(),
            buttonText: 'Y',
            onTap: onSettings,
            background: colorScheme.onBackground,
            textColor: colorScheme.background,
          ),
          IconButton(
            onPressed: onGameView,
            icon: const Icon(Icons.space_dashboard_rounded),
          ),
          const Spacer(),
          if (isSyncing)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSyncButton(
                  isSyncing: true,
                  onPressed: () {},
                ),
                Text('${'syncing'.i18n()}...'),
              ],
            ),
          if (!isSyncing)
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _BatteryIcon(),
                _HourIcon(),
              ],
            ),
          const Spacer(),
          LabelButton(
            label: 'favorite'.i18n(),
            buttonText: 'X',
            onTap: onFavorite,
            background: colorScheme.onBackground,
            textColor: colorScheme.background,
          ),
          const Gap(17),
          LabelButton(
            label: 'play'.i18n(),
            buttonText: 'A',
            onTap: onPlay,
            background: colorScheme.onBackground,
            textColor: colorScheme.background,
          ),
        ],
      ),
    );
  }
}

class _HourIcon extends StatelessWidget {
  const _HourIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return Text(
          hoursState.value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class _BatteryIcon extends StatelessWidget {
  const _BatteryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (_) {
      final model = batteryState.value;
      var type = BasedBatteryStatusType.normal;
      if (model.batteryState == BatteryState.charging) {
        type = BasedBatteryStatusType.charging;
      }

      return Transform.translate(
        offset: const Offset(0, -2),
        child: Transform.rotate(
          angle: -pi / 2,
          alignment: Alignment.center,
          child: BasedBatteryIndicator(
            status: BasedBatteryStatus(
              value: model.batteryLevel,
              type: type,
            ),
            trackHeight: 8.0,
            trackAspectRatio: 2.0,
            curve: Curves.ease,
            duration: const Duration(seconds: 1),
          ),
        ),
      );
    });
  }
}

class LabelButton extends StatelessWidget {
  final String label;
  final String buttonText;
  final Color background;
  final Color textColor;
  final VoidCallback? onTap;

  const LabelButton({
    super.key,
    required this.label,
    required this.buttonText,
    required this.background,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 10,
              ),
            ),
          ),
          const Gap(5),
          Text(label),
        ],
      ),
    );
  }
}
