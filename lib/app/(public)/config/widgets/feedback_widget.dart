import 'package:flutter/material.dart';
import 'package:yuno/app/interactor/actions/config_action.dart';

class FeedbackWidget extends StatelessWidget {
  FeedbackWidget({super.key});

  final Uri _url = Uri.https('github.com', '/Flutterando/yuno/issues');

  Future<void> _goToContribution() {
    return openUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "We appreciate your feedback and contributions to improving YuNO! If you encountered a bug while using YuNO or have an idea for a new feature or improvement, help us improve by creating an issue and describing the problem/improvement in as much detail as possible, don't forget to follow the contribution guide.",
            textAlign: TextAlign.justify,
          ),
          TextButton(
            onPressed: _goToContribution,
            child: const Text('Report a bug'),
          ),
          TextButton(
            onPressed: _goToContribution,
            child: const Text('Request a feature'),
          ),
        ],
      ),
    );
  }
}
