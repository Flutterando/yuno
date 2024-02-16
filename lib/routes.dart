import 'package:routefly/routefly.dart';

import 'app/(public)/apps_page.dart' as a0;
import 'app/(public)/config/config_page.dart' as a1;
import 'app/(public)/config/edit_platform_page.dart' as a2;
import 'app/(public)/home/grid_page.dart' as a3;
import 'app/(public)/home/list_page.dart' as a4;
import 'app/(public)/splash_page.dart' as a5;

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
    key: '/config/edit_platform',
    uri: Uri.parse('/config/edit_platform'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a2.EditPlatformPage(),
    ),
  ),
  RouteEntity(
    key: '/home/grid',
    uri: Uri.parse('/home/grid'),
    routeBuilder: a3.routeBuilder,
  ),
  RouteEntity(
    key: '/home/list',
    uri: Uri.parse('/home/list'),
    routeBuilder: a4.routeBuilder,
  ),
  RouteEntity(
    key: '/splash',
    uri: Uri.parse('/splash'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a5.AppPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  apps: '/apps',
  config: (
    path: '/config',
    editPlatform: '/config/edit_platform',
  ),
  home: (
    path: '/home',
    grid: '/home/grid',
    list: '/home/list',
  ),
  splash: '/splash',
);
