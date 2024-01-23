import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTitleAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final Color? backgroundColor;
  final Color? surfaceTintColor;

  AnimatedTitleAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.surfaceTintColor,
    this.actions = const [],
    this.leading,
  }) : assert(title.isNotEmpty);

  @override
  State<AnimatedTitleAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<AnimatedTitleAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late TextEditingController textEditingController;
  var title = '';

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    controller.addListener(() {
      var textoParcial = widget.title
          .substring(0, (widget.title.length * controller.value).round());

      if (textoParcial != widget.title) {
        textoParcial += getRandomCharacter();
      }

      setState(() {
        title = textoParcial;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  String getRandomCharacter() {
    Random random = Random();
    int choice = random.nextInt(3);

    if (choice == 0) {
      // Gera um número aleatório (ASCII 48 a 57)
      return String.fromCharCode(random.nextInt(10) + 48);
    } else if (choice == 1) {
      // Gera uma letra maiúscula aleatória (ASCII 65 a 90)
      return String.fromCharCode(random.nextInt(26) + 65);
    } else {
      // Gera uma letra minúscula aleatória (ASCII 97 a 122)
      return String.fromCharCode(random.nextInt(26) + 97);
    }
  }

  @override
  didUpdateWidget(AnimatedTitleAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title) {
      controller.reset();
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      backgroundColor: widget.backgroundColor,
      surfaceTintColor: widget.surfaceTintColor,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'YuNO',
            style: GoogleFonts.lemon(),
          ),
          const Text(' - '),
          Text(title),
        ],
      ),
      actions: widget.actions,
    );
  }
}
