import 'package:flutter/foundation.dart';

class FileDocument {
  final String name;
  final String uriString;
  final Future<Uint8List> Function()? getBytes;

  FileDocument({
    required this.name,
    required this.uriString,
    this.getBytes,
  });
}
