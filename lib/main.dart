import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuno/injector.dart';

import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  injector.commit();
  runApp(const AppWidget());
}
