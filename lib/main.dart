import 'package:flutter/material.dart';
import 'package:yuno/injector.dart';

import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injector.commit();
  runApp(const AppWidget());
}
