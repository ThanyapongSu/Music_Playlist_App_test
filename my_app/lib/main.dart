import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_app/pages/playlist.dart';
import 'package:my_app/service/audio_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => AudioService(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: PlayList(),
    );
  }
}
