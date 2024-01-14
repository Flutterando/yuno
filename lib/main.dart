import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:yuno/injector.dart';

import 'app/app_widget.dart';
import 'app/interactor/actions/config_action.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  GoogleFonts.lemon();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  WakelockPlus.enable();
  injector.commit();

  await fetchConfig();
  await GoogleFonts.pendingFonts();

  runApp(const AppWidget());
}
