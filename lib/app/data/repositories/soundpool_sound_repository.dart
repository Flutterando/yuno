import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

import '../../interactor/repositories/sound_repository.dart';

class SoundpoolSoundRepository extends SoundRepository {
  final Soundpool _soundPool;

  SoundpoolSoundRepository._(this._soundPool);

  factory SoundpoolSoundRepository() {
    return SoundpoolSoundRepository._(Soundpool.fromOptions(
      options: const SoundpoolOptions(streamType: StreamType.music),
    ));
  }

  int _clickSoundId = 0;
  int _doubleSoundId = 0;
  int _enterSoundId = 0;
  int _introSoundId = 0;
  int _openRailId = 0;

  @override
  Future<void> precacheCache() async {
    _clickSoundId = await rootBundle
        .load(SoundAssets.click.soundPath)
        .then((ByteData soundData) {
      return _soundPool.load(soundData);
    });
    _doubleSoundId = await rootBundle
        .load(SoundAssets.double.soundPath)
        .then((ByteData soundData) {
      return _soundPool.load(soundData);
    });
    _enterSoundId = await rootBundle
        .load(SoundAssets.enter.soundPath)
        .then((ByteData soundData) {
      return _soundPool.load(soundData);
    });
    _introSoundId = await rootBundle
        .load(SoundAssets.intro.soundPath)
        .then((ByteData soundData) {
      return _soundPool.load(soundData);
    });
    _openRailId = await rootBundle
        .load(SoundAssets.openRail.soundPath)
        .then((ByteData soundData) {
      return _soundPool.load(soundData);
    });
  }

  @override
  Future<int> playSound(SoundAssets sound) {
    return switch (sound) {
      SoundAssets.click => _soundPool.play(_clickSoundId),
      SoundAssets.double => _soundPool.play(_doubleSoundId),
      SoundAssets.enter => _soundPool.play(_enterSoundId),
      SoundAssets.intro => _soundPool.play(_introSoundId),
      SoundAssets.openRail => _soundPool.play(_openRailId),
    };
  }
}
