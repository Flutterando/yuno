import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:localization/localization.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:yuno/app/interactor/models/file_document.dart';
import 'package:yuno/app/interactor/repositories/storage_repository.dart';
import 'package:shared_storage/shared_storage.dart' as shared_storage;
import 'package:path_provider/path_provider.dart' as path_provider;

class MediaStorageRepository implements StorageRepository {
  @override
  Future<Uri?> getDirectoryUri([String? initialFolder]) async {
    final uri = await shared_storage.openDocumentTree(
        initialUri: initialFolder == null ? null : Uri.parse(initialFolder));
    return uri;
  }

  @override
  Future<bool> canReadFileByUri(Uri uri) async {
    final canRead = await shared_storage.canRead(uri);
    return canRead != true;
  }

  @override
  Future<void> persistedUriPermissions() async {
    await shared_storage.persistedUriPermissions();
  }

  @override
  Future<List<FileDocument>> getDocumentTree(String uriString) async {
    final media = MediaStore();
    final doc = await media.getDocumentTree(uriString: uriString);
    if (doc == null) return [];
    return doc.children
        .map((e) => FileDocument(
              name: e.name ?? '',
              uriString: e.uriString,
            ))
        .toList();
  }

  @override
  Future<String> getApplicationImagesDirectory() async {
    final divide = Platform.pathSeparator;
    return '${(await path_provider.getApplicationDocumentsDirectory()).path}${divide}images';
  }

  @override
  Future<FileDocument?> selectFile(
      [List<String>? extensions, bool ramdonName = true]) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'cover'.i18n(),
      extensions: extensions,
    );
    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file == null) {
      return null;
    }

    final extension = _getExtensionFromMimeType(file.mimeType!);
    final name = '${DateTime.now().millisecondsSinceEpoch}.$extension';

    return FileDocument(
      name: ramdonName ? name : file.name,
      uriString: file.path,
      getBytes: file.readAsBytes,
    );
  }

  String _getExtensionFromMimeType(String mimeType) {
    switch (mimeType) {
      case 'image/jpeg':
      case 'image/jpg':
        return 'jpg';
      case 'image/png':
        return 'png';
      default:
        return 'unknown';
    }
  }
}
