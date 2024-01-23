import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
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
          Text(
            "feedback_long_text".i18n(),
            textAlign: TextAlign.justify,
          ),
          TextButton(
            onPressed: _goToContribution,
            child: Text('report_bug'.i18n()),
          ),
          TextButton(
            onPressed: _goToContribution,
            child: Text('request_feature'.i18n()),
          ),
        ],
      ),
    );
  }
}
