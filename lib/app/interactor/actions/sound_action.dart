import '../../../injector.dart';
import '../atoms/config_atom.dart';
import '../repositories/sound_repository.dart';

SoundRepository? _soundRepository;

Future<void> soundPrecache() {
  _soundRepository ??= injector.get<SoundRepository>();
  return _soundRepository!.precacheCache();
}

Future<void> playSound(SoundAssets sound) async {
  if (!gameConfigState.value.menuSounds) return;

  _soundRepository ??= injector.get<SoundRepository>();
  await _soundRepository!.playSound(sound);
}
