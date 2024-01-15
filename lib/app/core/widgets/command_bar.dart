import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NavigationCommand extends StatelessWidget {
  final VoidCallback? onApps;
  final VoidCallback? onSettings;
  final VoidCallback? onPlay;
  final ColorScheme colorScheme;

  const NavigationCommand({super.key, this.onApps, this.onSettings, this.onPlay, required this.colorScheme});

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
            label: 'Apps',
            buttonText: 'B',
            onTap: onApps,
            background: colorScheme.onBackground,
            textColor: colorScheme.background,
          ),
          const Gap(17),
          LabelButton(
            label: 'Settings',
            buttonText: 'Y',
            onTap: onSettings,
            background: colorScheme.onBackground,
            textColor: colorScheme.background,
          ),
          const Spacer(),
          LabelButton(
            label: 'Play',
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
