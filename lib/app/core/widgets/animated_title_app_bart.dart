import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTitleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;

  AnimatedTitleAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.leading,
  }) : assert(title.isNotEmpty);

  @override
  State<AnimatedTitleAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<AnimatedTitleAppBar> with SingleTickerProviderStateMixin {
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
      final textoParcial = widget.title.substring(0, (widget.title.length * controller.value).round());

      setState(() {
        title = textoParcial;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
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
