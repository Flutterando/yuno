import 'package:flutter/material.dart';

class CardTile extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;
  final bool selected;
  const CardTile({
    super.key,
    required this.title,
    this.onTap,
    this.selected = false,
  });

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  @override
  Widget build(BuildContext context) {
    final scale = widget.selected ? 1.0 : 0.98;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(scale),
      transformAlignment: Alignment.center,
      alignment: Alignment.center,
      //margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
          width: 1,
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onTap,
          child: const Center(
            child: Icon(Icons.image_not_supported_outlined),
          ),
        ),
      ),
    );
  }
}
