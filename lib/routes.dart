import 'package:routefly/routefly.dart';

import 'app/(public)/app_page.dart' as a2;
import 'app/(public)/config/config_page.dart' as a0;
import 'app/(public)/home_page.dart' as a1;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/config',
    uri: Uri.parse('/config'),
    routeBuilder: a0.routeBuilder,
  ),
  RouteEntity(
    key: '/home',
    uri: Uri.parse('/home'),
    routeBuilder: a1.routeBuilder,
  ),
  RouteEntity(
    key: '/',
    uri: Uri.parse('/'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a2.AppPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  config: '/config',
  home: '/home',
);
