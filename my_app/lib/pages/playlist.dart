import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../service/audio_service.dart';
import 'music_in_playlist.dart';

class Playlist {
  final String title;
  final List<Song> songs;

  Playlist(this.title, this.songs);
}

class Song {
  final String title;
  final String artist;
  final String url;
  final String coverUrl;

  Song(this.title, this.artist, this.url, this.coverUrl);
}

class PlayList extends StatelessWidget {
  final List<Playlist> playlists = [
    Playlist('Crazy World', [
      Song(
          'Wind of change',
          'Scorpians',
          'assets/crazyworld/04_Wind_of_change.mp3',
          'assets/crazyworld/crazyworld.jpg'),
      Song(
          'Restless nights',
          'Scorpians',
          'assets/crazyworld/05_Restless_nights.mp3',
          'assets/crazyworld/crazyworld.jpg'),
    ]),
    Playlist('Tech House Vibes', [
      Song('Crazy world', 'A&K', 'assets/crazyworld/10_Crazy_world.mp3',
          'assets/headphone.jpg'),
      Song('Send me an angel', 'A&K',
          'assets/crazyworld/11_Send_me_an_angel.mp3', 'assets/headphone.jpg'),
    ]),
    Playlist('Summer Hot Hits', [
      Song('Tease me please me', 'Hits',
          'assets/crazyworld/01_Tease_me_please_me.mp3', 'assets/summer.jpg'),
      Song("Don't believe her", 'Hits',
          'assets/crazyworld/02_Dont_believe_her.mp3', 'assets/summer.jpg'),
    ]),
    Playlist('Techno Pump Up', [
      Song('Pump Up The Jam', 'Techno Group',
          'assets/techno/Pump_Up_The_Jam.mp3', 'assets/techno.jpg'),
      Song('Tokyo Drift', 'Techno Group', 'assets/techno/Tokyo_Drift.mp3',
          'assets/techno.jpg'),
    ]),
    Playlist('Vibe With Me', [
      Song('Vibe Song1', 'Housy', 'assets/audio1.mp3', 'assets/vibe.jpg'),
      Song('Vibe Song2', 'Housy', 'assets/audio2.mp3', 'assets/vibe.jpg'),
    ]),
    Playlist('Listen&Chill', [
      Song('Breathe', 'PinkFloyd', 'assets/darkside/02_Breathe.mp3',
          'assets/chill.jpg'),
      Song('Time', 'PinkFloyd', 'assets/darkside/04_Time.mp3',
          'assets/chill.jpg'),
      Song('Money', 'PinkFloyd', 'assets/darkside/06_Money.mp3',
          'assets/chill.jpg'),
      Song('Brain Damage', 'PinkFloyd', 'assets/darkside/09_Brain_Damage.mp3',
          'assets/chill.jpg'),
      Song('Eclipse', 'PinkFloyd', 'assets/darkside/10_Eclipse.mp3',
          'assets/chill.jpg'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 80.0, right: 200.0),
            child: Text(
              "My Playlist",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playlists.length,
              padding: const EdgeInsets.only(bottom: 150.0),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(playlists[index].songs[0].coverUrl),
                    ),
                  ),
                  title: Text(playlists[index].title),
                  subtitle: Text(playlists[index].songs[0].artist),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () async {
                      audioService.selectPlaylist(playlists[index]);
                      audioService.selectSong(0);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MusicInPlaylistPage(playlist: playlists[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: audioService.currentSong == null
          ? null
          : Consumer<AudioService>(
              builder: (context, audioService, child) {
                return Container(
                  height: 150,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        StreamBuilder<Duration>(
                          stream: audioService.audioPlayer.positionStream,
                          builder: (context, snapshot) {
                            final position = snapshot.data ?? Duration.zero;
                            return StreamBuilder<Duration?>(
                              stream: audioService.audioPlayer.durationStream,
                              builder: (context, snapshot) {
                                var duration = snapshot.data ?? Duration.zero;
                                return Slider(
                                  onChanged: (value) {
                                    audioService.audioPlayer
                                        .seek(Duration(seconds: value.round()));
                                  },
                                  value: position.inSeconds.toDouble(),
                                  min: 0.0,
                                  max: duration.inSeconds.toDouble(),
                                );
                              },
                            );
                          },
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 5),
                              child: Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    audioService.currentSong!.coverUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: Column(
                                  children: [
                                    Text(audioService.currentSong!.title),
                                    Text(audioService.currentSong!.artist),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  15.0),
                              child: StreamBuilder<bool>(
                                stream: audioService.audioPlayer.playingStream,
                                builder: (context, snapshot) {
                                  final isPlaying = snapshot.data ?? false;
                                  return IconButton(
                                    icon: Icon(isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    onPressed: () {
                                      isPlaying
                                          ? audioService.audioPlayer.pause()
                                          : audioService.audioPlayer.play();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
