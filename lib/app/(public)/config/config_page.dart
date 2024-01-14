import 'package:flutter/material.dart';

import '../../core/widgets/animated_title_app_bart.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnimatedTitleAppBar(
        title: 'Config',
      ),
      // body: const Placeholder(),
      // floatingActionButton: AnimatedFloatingActionButton(
      //   onPressed: () async {},
      //   label: 'Add Game',
      //   icon: Icons.add,
      //   animation: widget.transitionAnimation,
      // ),
    );
  }
}
