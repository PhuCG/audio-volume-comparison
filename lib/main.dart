import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final urlAudio =
      "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3";
  // 'https://api-dev.ahaspeak.app/speech?text=Nice%20to%20meet%20you,%20Jack.%20How%20are%20you?&style=friendly&voice=en-AU-CarlyNeural&speed=normal';

  late AudioPlayer _justAudioPlayer;
  late Player _mediaKitPlayer;

  @override
  void initState() {
    super.initState();
    _justAudioPlayer = AudioPlayer();
    _mediaKitPlayer = Player();
  }

  @override
  void dispose() {
    _justAudioPlayer.dispose();
    _mediaKitPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Just Audio'),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () async {
                  await _justAudioPlayer.setUrl(urlAudio);
                  await _justAudioPlayer.play();
                },
                child: const Text('Play URL'),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              const Text('Media Kit'),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () async {
                  await _mediaKitPlayer.open(Media(urlAudio));
                },
                child: const Text('Play URL'),
              ),
              const Divider(),
              TextButton(
                onPressed: () async {
                  await _mediaKitPlayer.stop();
                  await _justAudioPlayer.stop();
                },
                child: const Text('Stop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
