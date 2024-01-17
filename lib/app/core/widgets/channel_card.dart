import 'package:flutter/material.dart';

class ChannelCard extends StatelessWidget {
  final void Function()? onTap;
  final String imageIcon;
  final String channelName;

  const ChannelCard({
    super.key,
    this.onTap,
    required this.imageIcon,
    required this.channelName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imageIcon,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(channelName),
            )
          ],
        ),
      ),
    );
  }
}
