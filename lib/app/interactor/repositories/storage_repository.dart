import '../models/file_document.dart';

abstract class StorageRepository {
  Future<Uri?> getDirectoryUri([String? initialFolder]);
  Future<bool> canReadFileByUri(Uri uri);
  Future<void> persistedUriPermissions();
  Future<List<FileDocument>> getDocumentTree(String uriString);
  Future<String> getApplicationImagesDirectory();
  Future<FileDocument?> selectFile([List<String>? extensions]);
}
