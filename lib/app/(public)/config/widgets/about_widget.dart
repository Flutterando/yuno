import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutWidget extends StatelessWidget {
  AboutWidget({super.key});

  final Uri _url = Uri.https('github.com', '/Flutterando/yuno');
  Future<void> _seeMoreLaunchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception("Cold't launch");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'YuNO',
          style: GoogleFonts.lemon(
            fontSize: 47.5,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
          child: Text(
            'Yuno is a minimalist, open-source retro gaming frontend designed to deliver a nostalgic and efficient gaming experience. This project aims to create a simplified interface for accessing and playing your favorite retro games.',
            textAlign: TextAlign.justify,
          ),
        ),
        TextButton(
          onPressed: _seeMoreLaunchUrl,
          child: const Text('See more'),
        )
      ],
    );
  }
}
