import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import '../pages/playlist.dart';

class AudioService extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  Playlist? currentPlaylist;
  int currentIndex = 0;

  AudioPlayer get audioPlayer => _player;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<SequenceState?> get sequenceStateStream => _player.sequenceStateStream;

  Song? get currentSong =>
      currentPlaylist == null ? null : currentPlaylist!.songs[currentIndex];

  AudioService() {
    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });
  }

  void selectPlaylist(Playlist playlist) {
    print("Selecting playlist: ${playlist.title}");
    currentPlaylist = playlist;
    currentIndex = 0;
    _playCurrentSong();
  }

  void selectSong(int index) {
    print("Selecting song with index: $index");
    currentIndex = index;
    _playCurrentSong();
  }

  void playNextSong() {
    if (currentPlaylist != null &&
        currentIndex + 1 < currentPlaylist!.songs.length) {
      currentIndex++;
      _playCurrentSong();
    }
  }

  void _playCurrentSong() {
    if (currentSong != null) {
      print("Playing song with index: $currentIndex");
      print("Song URL: ${currentSong!.url}");

      if (currentSong!.url != null) {
        _player.setAsset(currentSong!.url!);
        _player.play();
        notifyListeners();
      } else {
        print("Song URL is null");
      }
    } else {
      print("Current song is null");
    }
  }

  void playSong(Song song) {
    if (song == null) {
      print("The song is null.");
    } else if (currentPlaylist == null) {
      print("The current playlist is null.");
    } else if (!currentPlaylist!.songs.contains(song)) {
      print("The song is not in the current playlist.");
    } else {
      print("Playing song: ${song.title}");
      currentIndex = currentPlaylist!.songs.indexOf(song);
      _playCurrentSong();
    }
  }
}
