import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:yuno/app/interactor/atoms/config_atom.dart';

final _pool = Soundpool.fromOptions(options: const SoundpoolOptions(streamType: StreamType.notification));

const _clickSound = 'assets/sounds/click.mp3';
int _clickSoundId = 0;
void clickSound() {
  if (!gameConfigState.value.menuSounds) return;
  _pool.play(_clickSoundId);
}

const _doubleSound = 'assets/sounds/double.mp3';
int _doubleSoundId = 0;
void doubleSound() {
  if (!gameConfigState.value.menuSounds) return;
  _pool.play(_doubleSoundId);
}

const _enterSound = 'assets/sounds/enter.mp3';
int _enterSoundId = 0;
void enterSound() {
  if (!gameConfigState.value.menuSounds) return;
  _pool.play(_enterSoundId);
}

const _introSound = 'assets/sounds/intro.mp3';
int _introSoundId = 0;
void introSound() {
  if (!gameConfigState.value.menuSounds) return;
  _pool.play(_introSoundId);
}

const _openRailSound = 'assets/sounds/open_rail.mp3';
int _openRailId = 0;
void openRail() {
  if (!gameConfigState.value.menuSounds) return;
  _pool.play(_openRailId);
}

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

  _openRailId = await rootBundle.load(_openRailSound).then((ByteData soundData) {
    return _pool.load(soundData);
  });
}
