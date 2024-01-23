import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NoItemWidget extends StatelessWidget {
  final String title;

  const NoItemWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 90,
      width: 220,
      alignment: Alignment.center,
      color: colorScheme.surfaceVariant.withOpacity(0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const Gap(3),
          const Icon(Icons.gamepad_outlined),
        ],
      ),
    );
  }
}
