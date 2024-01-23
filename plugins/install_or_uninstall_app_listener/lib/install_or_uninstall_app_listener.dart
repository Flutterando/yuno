import 'package:flutter/services.dart';

abstract class InstallOrUninstallAppListener {
  static const EventChannel _eventChannel =
      EventChannel('br.com.flutterando.install_or_uninstall_app_listener');

  static Stream<String>? _onAppInstallUninstall;

  static Stream<String> get onAppInstallUninstall {
    _onAppInstallUninstall ??= _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as String);
    return _onAppInstallUninstall!;
  }
}
