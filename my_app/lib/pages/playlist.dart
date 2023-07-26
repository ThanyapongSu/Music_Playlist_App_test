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

// class PlayList extends StatefulWidget {
//   @override
//   _PlayListState createState() => _PlayListState();
// }

// class _PlayListState extends State<PlayList> {
//   late AudioService audioService;

//   final List<Playlist> playlists = [
//     Playlist('Dark Side Of The Moon', [
//       Song('Speak To Me', 'PinkFloyd', 'assets/darkside/01_Speak_To_Me.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song('Breathe', 'PinkFloyd', 'assets/darkside/02_Breathe.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song('On The Run', 'PinkFloyd', 'assets/darkside/03_On_The_Run.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song('Time', 'PinkFloyd', 'assets/darkside/04_Time.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song(
//           'The Great Gig In The Sky',
//           'PinkFloyd',
//           'assets/darkside/05_The_Great_Gig_In_The_Sky.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song('Money', 'PinkFloyd', 'assets/darkside/06_Money.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song('Us And Them', 'PinkFloyd', 'assets/darkside/07_Us_And_Them.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song(
//           'Any Colour You Like',
//           'PinkFloyd',
//           'assets/darkside/08_Any_Colour_You_Like.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song('Brain Damage', 'PinkFloyd', 'assets/darkside/09_Brain_Damage.mp3',
//           'assets/darkside/darkside.jpg'),
//       Song('Eclipse', 'PinkFloyd', 'assets/darkside/10_Eclipse.mp3',
//           'assets/darkside/darkside.jpg'),
//     ]),
//     Playlist('Playlist2', [
//       Song('Song1', 'PinkFloyd3', 'assets/audio1.mp3',
//           'assets/thewall/thewall.jpg'),
//       Song('Song2', 'PinkFloyd4', 'assets/audio2.mp3',
//           'assets/thewall/thewall.jpg'),
//       // Add more songs to your list
//     ]),
//     Playlist('Playlist3', [
//       Song(
//           'Song1', 'PinkFloyd5', 'assets/audio1.mp3', 'assets/shine/shine.jpg'),
//       Song(
//           'Song2', 'PinkFloyd6', 'assets/audio2.mp3', 'assets/shine/shine.jpg'),
//       // Add more songs to your list
//     ]),
//     Playlist('Playlist4', [
//       Song('Song1', 'Scorpians1', 'assets/audio1.mp3',
//           'assets/crazyworld/crazyworld.jpg'),
//       Song('Song2', 'Scorpians2', 'assets/audio2.mp3',
//           'assets/crazyworld/crazyworld.jpg'),
//       // Add more songs to your list
//     ]),
//     // Add more playlists to your list
//   ];

//   Playlist? currentPlaylist;

//   @override
//   void initState() {
//     super.initState();
//     audioService = Provider.of<AudioService>(context, listen: false);
//     audioService.audioPlayer.playerStateStream.listen((playerState) async {
//       print("Player state: ${playerState.processingState}"); // Add this line.
//       if (playerState.processingState == ProcessingState.completed) {
//         await Future.delayed(Duration(milliseconds: 1000));
//         playNextSong();
//       }
//     });
//   }

//   void playNextSong() {
//     print("playNextSong called in playlist"); // Keep this line.
//     if (currentPlaylist != null && audioService.currentSong != null) {
//       var currentSongIndex =
//           currentPlaylist!.songs.indexOf(audioService.currentSong!);

//       print(
//           "Current song index in playlist: $currentSongIndex"); // Keep this line.

//       if (currentSongIndex + 1 < currentPlaylist!.songs.length) {
//         audioService.currentSong = currentPlaylist!.songs[currentSongIndex + 1];
//         audioService.playSong(audioService.currentSong!);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.only(top: 80.0, right: 200.0),
//             child: Text(
//               "My Playlist",
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // Song list
//           Expanded(
//             child: ListView.builder(
//               itemCount: playlists.length,
//               padding: const EdgeInsets.only(bottom: 150.0),
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0)),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: Image.asset(playlists[index].songs[0].coverUrl),
//                     ),
//                   ),
//                   title: Text(playlists[index].title),
//                   subtitle: Text(playlists[index].songs[0].artist),
//                   trailing: IconButton(
//                     icon: Icon(Icons.play_arrow),
//                     onPressed: () async {
//                       setState(() {
//                         currentPlaylist = playlists[index];
//                         audioService.currentSong = playlists[index].songs[0];
//                       });
//                       await audioService.audioPlayer
//                           .setAsset(playlists[index].songs[0].url);
//                       await audioService.audioPlayer.play();
//                     },
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             MusicInPlaylistPage(playlist: playlists[index]),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomSheet: audioService.currentSong == null
//           ? null
//           : Consumer<AudioService>(
//               builder: (context, audioService, child) {
//                 return Container(
//                   height: 150,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         // Move the Slider to the top
//                         StreamBuilder<Duration>(
//                           stream: audioService.audioPlayer.positionStream,
//                           builder: (context, snapshot) {
//                             final position = snapshot.data ?? Duration.zero;
//                             return StreamBuilder<Duration?>(
//                               stream: audioService.audioPlayer.durationStream,
//                               builder: (context, snapshot) {
//                                 var duration = snapshot.data ?? Duration.zero;
//                                 return Slider(
//                                   onChanged: (value) {
//                                     audioService.audioPlayer
//                                         .seek(Duration(seconds: value.round()));
//                                   },
//                                   value: position.inSeconds.toDouble(),
//                                   min: 0.0,
//                                   max: duration.inSeconds.toDouble(),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 20.0,
//                                   right: 5), // Adjust the padding as needed
//                               child: Container(
//                                 width: 80.0,
//                                 height: 80.0,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   child: Image.asset(
//                                     audioService.currentSong!.coverUrl,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(
//                                     8.0), // Adjust the padding as needed
//                                 child: Column(
//                                   children: [
//                                     Text(audioService.currentSong!.title),
//                                     Text(audioService.currentSong!.artist),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(
//                                   15.0), // Adjust the padding as needed
//                               child: StreamBuilder<bool>(
//                                 stream: audioService.audioPlayer.playingStream,
//                                 builder: (context, snapshot) {
//                                   final isPlaying = snapshot.data ?? false;
//                                   return IconButton(
//                                     icon: Icon(isPlaying
//                                         ? Icons.pause
//                                         : Icons.play_arrow),
//                                     onPressed: () {
//                                       isPlaying
//                                           ? audioService.audioPlayer.pause()
//                                           : audioService.audioPlayer.play();
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

class PlayList extends StatelessWidget {
  final List<Playlist> playlists = [
    // Playlist('Dark Side Of The Moon', [
    //   // Song('Breathe', 'PinkFloyd', 'assets/darkside/02_Breathe.mp3',
    //   //     'assets/darkside/darkside.jpg'),
    //   // Song('Time', 'PinkFloyd', 'assets/darkside/04_Time.mp3',
    //   //     'assets/darkside/darkside.jpg'),
    //   Song('Money', 'PinkFloyd', 'assets/darkside/06_Money.mp3',
    //       'assets/darkside/darkside.jpg'),
    // ]),
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
                        // Move the Slider to the top
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
                                  right: 5), // Adjust the padding as needed
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
                                    8.0), // Adjust the padding as needed
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
                                  15.0), // Adjust the padding as needed
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
