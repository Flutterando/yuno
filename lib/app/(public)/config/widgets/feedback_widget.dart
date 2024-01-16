import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackWidget extends StatelessWidget {
  FeedbackWidget({super.key});

  final Uri _url =
      Uri.https('github.com', 'Flutterando/yuno/blob/main/CONTRIBUTING.md');

  Future<void> _goToContribution() async {
    if (!await launchUrl(_url)) {
      throw Exception("Cold't launch");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Feedback',
          style: GoogleFonts.lemon(
            fontSize: 47.5,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
          child: Text(
            "We appreciate your feedback and contributions to improving Yuno! If you encountered a bug while using Yuno or have an idea for a new feature or improvement, help us improve by creating an issue and describing the problem/improvement in as much detail as possible, don't forget to follow the contribution guide.",
            textAlign: TextAlign.justify,
          ),
        ),
        TextButton(
          onPressed: _goToContribution,
          child: const Text('Contribution Guidelines'),
        ),
      ],
    );
  }
}
