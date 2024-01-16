import 'package:routefly/routefly.dart';

import 'app/(public)/apps_page.dart' as a0;
import 'app/(public)/config/config_page.dart' as a1;
import 'app/(public)/home_page.dart' as a2;
import 'app/(public)/splash_page.dart' as a3;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/apps',
    uri: Uri.parse('/apps'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a0.AppsPage(),
    ),
  ),
  RouteEntity(
    key: '/config',
    uri: Uri.parse('/config'),
    routeBuilder: a1.routeBuilder,
  ),
  RouteEntity(
    key: '/home',
    uri: Uri.parse('/home'),
    routeBuilder: a2.routeBuilder,
  ),
  RouteEntity(
    key: '/splash',
    uri: Uri.parse('/splash'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a3.AppPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  apps: '/apps',
  config: '/config',
  home: '/home',
  splash: '/splash',
);
