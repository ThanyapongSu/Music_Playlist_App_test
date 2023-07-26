// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';

// import '../service/audio_service.dart';
// import 'playlist.dart';

// class MusicInPlaylistPage extends StatefulWidget {
//   final Playlist playlist;

//   MusicInPlaylistPage({required this.playlist});

//   @override
//   _MusicInPlaylistPageState createState() => _MusicInPlaylistPageState();
// }

// class _MusicInPlaylistPageState extends State<MusicInPlaylistPage> {
//   late AudioService audioService;

//   StreamSubscription<PlayerState>? playerStateStreamSubscription;

//   @override
//   void initState() {
//     super.initState();
//     audioService = Provider.of<AudioService>(context, listen: false);
//   }

//   @override
//   void dispose() {
//     playerStateStreamSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.playlist.title)),
//       body: Consumer<AudioService>(
//         builder: (context, audioService, child) {
//           return Column(
//             children: [
//               // Album cover
//               Container(
//                 width: double.infinity,
//                 height: 300,
//                 child: Image.asset(
//                   widget.playlist.songs[0].coverUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               // Song list
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: widget.playlist.songs.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: audioService.currentSong ==
//                               widget.playlist.songs[index]
//                           ? Icon(Icons.music_note)
//                           : null,
//                       title: Text(widget.playlist.songs[index].title),
//                       subtitle: Text(widget.playlist.songs[index].artist),
//                       trailing: IconButton(
//                         icon: Icon(Icons.play_arrow),
//                         onPressed: () {
//                           setState(() {
//                             audioService.currentSong =
//                                 widget.playlist.songs[index];
//                           });
//                           audioService.playSong(audioService.currentSong!);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../service/audio_service.dart';
import 'playlist.dart';

// class MusicInPlaylistPage extends StatefulWidget {
//   final Playlist playlist;

//   MusicInPlaylistPage({required this.playlist});

//   @override
//   _MusicInPlaylistPageState createState() => _MusicInPlaylistPageState();
// }

// class _MusicInPlaylistPageState extends State<MusicInPlaylistPage> {
//   late AudioService audioService;

//   @override
//   void initState() {
//     super.initState();
//     audioService = Provider.of<AudioService>(context, listen: false);
//     audioService.audioPlayer.playerStateStream.listen((playerState) async {
//       print("Player state: ${playerState.processingState}"); // Add this line.
//       if (playerState.processingState == ProcessingState.completed) {
//         await Future.delayed(Duration(milliseconds: 1000)); // Add a short delay
//         playNextSong();
//       }
//     });
//   }

//   void playNextSong() {
//     print("playNextSong called in music_in_playlist"); // Keep this line.
//     if (audioService.currentSong != null) {
//       var currentSongIndex =
//           widget.playlist.songs.indexOf(audioService.currentSong!);

//       print(
//           "Current song index in music_in_playlist: $currentSongIndex"); // Keep this line.

//       if (currentSongIndex + 1 < widget.playlist.songs.length) {
//         setState(() {
//           audioService.currentSong =
//               widget.playlist.songs[currentSongIndex + 1];
//         });
//         audioService.playSong(audioService.currentSong!);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.playlist.title)),
//       body: Consumer<AudioService>(
//         builder: (context, audioService, child) {
//           return Column(
//             children: [
//               // Album cover
//               Container(
//                 width: double.infinity,
//                 height: 300,
//                 child: Image.asset(
//                   widget.playlist.songs[0].coverUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               // Song list
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: widget.playlist.songs.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: audioService.currentSong ==
//                               widget.playlist.songs[index]
//                           ? Icon(Icons.music_note)
//                           : null,
//                       title: Text(widget.playlist.songs[index].title),
//                       subtitle: Text(widget.playlist.songs[index].artist),
//                       trailing: IconButton(
//                         icon: Icon(Icons.play_arrow),
//                         onPressed: () {
//                           setState(() {
//                             audioService.currentSong =
//                                 widget.playlist.songs[index];
//                           });
//                           audioService.playSong(audioService.currentSong!);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class MusicInPlaylistPage extends StatelessWidget {
//   final Playlist playlist;

//   MusicInPlaylistPage({required this.playlist});

//   @override
//   Widget build(BuildContext context) {
//     var audioService = Provider.of<AudioService>(context);

//     return Scaffold(
//       body: Consumer<AudioService>(
//         builder: (context, audioService, child) {
//           return Column(
//             children: [
//               Stack(
//                 children: <Widget>[
//                   Container(
//                     width: double.infinity,
//                     height: 300,
//                     child: Image.asset(
//                       playlist.songs[0].coverUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                     top: MediaQuery.of(context).padding.top + 10,
//                     left: 10,
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: playlist.songs.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: audioService.currentSong == playlist.songs[index]
//                           ? Icon(Icons.music_note)
//                           : null,
//                       title: Text(playlist.songs[index].title),
//                       subtitle: Text(playlist.songs[index].artist),
//                       trailing: IconButton(
//                         icon: Icon(Icons.play_arrow),
//                         onPressed: () {
//                           audioService.playSong(playlist.songs[index]);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

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
                // Container(
                //   width: double.infinity,
                //   height: 300,
                //   child: Image.asset(
                //     playlist.songs[0].coverUrl,
                //     fit: BoxFit.cover,
                //   ),
                // ),
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
                            // audioService.playSong(playlist.songs[index]);
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
