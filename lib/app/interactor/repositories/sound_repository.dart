abstract class SoundRepository {
  Future<void> precacheCache();

  Future<int> playSound(SoundAssets sound);
}

enum SoundAssets {
  click('assets/sounds/click.mp3'),
  double('assets/sounds/double.mp3'),
  enter('assets/sounds/enter.mp3'),
  intro('assets/sounds/intro.mp3'),
  openRail('assets/sounds/open_rail.mp3');

  final String soundPath;

  const SoundAssets(this.soundPath);
}
