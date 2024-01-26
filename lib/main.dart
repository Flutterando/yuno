import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:yuno/injector.dart';

import 'app/app_widget.dart';
import 'app/data/repositories/isar/isar_datasource.dart';
import 'app/interactor/actions/config_action.dart';
import 'app/interactor/atoms/config_atom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  GoogleFonts.lemon();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  WakelockPlus.enable();
  registerInjectAndroidConfig(injector);
  injector.commit();

  await fetchConfig();
  await GoogleFonts.pendingFonts();

  final packageInfo = await PackageInfo.fromPlatform();
  buildNumberState.value = 'build-${packageInfo.buildNumber}';

  await IsarDatasource.init();

  runApp(const AppWidget());
}
