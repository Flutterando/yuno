import 'package:flutter/material.dart';

class SponsorsCard extends StatelessWidget {
  final void Function()? onTap;
  final String image;
  final String sponsorName;

  const SponsorsCard({
    super.key,
    this.onTap,
    required this.image,
    required this.sponsorName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 120,
        child: Column(
          children: <Widget>[
            Image.asset(
              image,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  sponsorName,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
