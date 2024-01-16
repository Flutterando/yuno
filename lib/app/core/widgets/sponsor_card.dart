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
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 120,
            child: Column(
              children: <Widget>[
                Image.asset(
                  image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  sponsorName,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
