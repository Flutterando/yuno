import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  final String text;
  final String subtext;
  final bool selected;
  final ColorScheme colorScheme;
  final void Function()? onTap;

  const AnimatedTile({
    super.key,
    required this.text,
    required this.subtext,
    required this.colorScheme,
    this.selected = false,
    this.onTap,
  });

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _controller.value = widget.selected ? 1 : 0;

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected == widget.selected) {
      return;
    }

    if (widget.selected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTranslate = Tween<Offset>(
      begin: const Offset(0, 10.0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    final subtextOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: widget.selected
            ? widget.colorScheme.surface
            : theme.colorScheme.surface,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: textTranslate.value,
                        child: Text(
                          widget.text,
                          maxLines: 1,
                          style: theme.textTheme.titleMedium?.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: widget.selected
                                ? widget.colorScheme.primary
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: subtextOpacity.value,
                        child: Text(
                          widget.subtext,
                          maxLines: 1,
                          style: theme.textTheme.bodySmall?.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: widget.selected
                                ? widget.colorScheme.primary
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: widget.selected
                      ? widget.colorScheme.primary
                      : theme.colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
