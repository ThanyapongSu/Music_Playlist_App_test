import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../service/audio_service.dart';
import 'playlist.dart';

class MusicInPlaylistPage extends StatelessWidget {
  final Playlist playlist;

  MusicInPlaylistPage({required this.playlist});

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.compareTo(0) == 1) {
          Navigator.pop(context);
        }
      },
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity!.compareTo(0) == 1) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Consumer<AudioService>(
          builder: (context, audioService, child) {
            return Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.asset(
                        playlist.songs[0].coverUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 10,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: playlist.songs.length,
                    padding: const EdgeInsets.only(bottom: 5.0),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            audioService.currentSong == playlist.songs[index]
                                ? Icon(Icons.music_note)
                                : null,
                        title: Text(playlist.songs[index].title),
                        subtitle: Text(playlist.songs[index].artist),
                        trailing: IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            audioService.selectPlaylist(playlist);
                            audioService.playSong(playlist.songs[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
