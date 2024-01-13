import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

final _pool = Soundpool.fromOptions(options: const SoundpoolOptions(streamType: StreamType.notification));

const _clickSound = 'assets/sounds/click.mp3';
int _clickSoundId = 0;
void clickSound() => _pool.play(_clickSoundId);

const _doubleSound = 'assets/sounds/double.mp3';
int _doubleSoundId = 0;
void doubleSound() => _pool.play(_doubleSoundId);

const _enterSound = 'assets/sounds/enter.mp3';
int _enterSoundId = 0;
void enterSound() => _pool.play(_enterSoundId);

const _introSound = 'assets/sounds/intro.mp3';
int _introSoundId = 0;
void introSound() => _pool.play(_introSoundId);

Future<void> precacheCache() async {
  _clickSoundId = await rootBundle.load(_clickSound).then((ByteData soundData) {
    return _pool.load(soundData);
  });
  _doubleSoundId = await rootBundle.load(_doubleSound).then((ByteData soundData) {
    return _pool.load(soundData);
  });
  _enterSoundId = await rootBundle.load(_enterSound).then((ByteData soundData) {
    return _pool.load(soundData);
  });
  _introSoundId = await rootBundle.load(_introSound).then((ByteData soundData) {
    return _pool.load(soundData);
  });
}
