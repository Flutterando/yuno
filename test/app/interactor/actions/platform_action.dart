import 'package:flutter_test/flutter_test.dart';
import 'package:yuno/app/interactor/actions/platform_action.dart';

void main() {
  test('Uri to path', () {
    expect(
      convertContentUriToFilePath(
          'content://com.android.externalstorage.documents/tree/primary%3AEmulation%2Frooms%2Fsnes/document/primary%3AEmulation%2Frooms%2Fsnes'),
      '/storage/emulated/0/Emulation/rooms/snes',
    );
  });

  test('clean name', () {
    final megaman = cleanName('Mega Man Zero 3.zip');
    expect(megaman, 'Mega Man Zero 3');
  });
}
