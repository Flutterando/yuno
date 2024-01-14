import 'package:flutter/material.dart';
import 'package:yuno/app/core/widgets/animated_floating_action_button.dart';

class PlatformWidget extends StatelessWidget {
  final Animation<double> transitionAnimation;
  const PlatformWidget({
    super.key,
    required this.transitionAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: AnimatedFloatingActionButton(
        onPressed: () async {},
        label: 'Add Platform',
        icon: Icons.add,
        animation: transitionAnimation,
      ),
    );
  }
}
