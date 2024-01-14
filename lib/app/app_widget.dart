import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:yuno/app/core/themes/theme.dart';
import 'package:yuno/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'YuNO',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: Routefly.routerConfig(routes: routes),
    );
  }
}
