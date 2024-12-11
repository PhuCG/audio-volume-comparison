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
  final audio1 =
      "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3";

  final audio2 =
      'https://api-dev.ahaspeak.app/speech?text=Nice%20to%20meet%20you,%20Jack.%20How%20are%20you?&style=friendly&voice=en-AU-CarlyNeural&speed=normal';

  final audio3 =
      'https://storage-dev.ahaspeak.app/scenario/00f6ce25-cb02-48be-ac25-5495428c5cfc/i_eat_dinner_and_watch_tv._i_go_to_bed_at_1000_pm._and_you.mp3';

  late AudioPlayer _justAudioPlayer;
  late Player _mediaKitPlayer;

  var audio = '';

  @override
  void initState() {
    super.initState();
    audio = audio1;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() => audio = audio1);
                    },
                    child: const Text('Play 1'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () async {
                      setState(() => audio = audio2);
                    },
                    child: const Text('Play 2'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () async {
                      setState(() => audio = audio3);
                    },
                    child: const Text('Play 3'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              const Text('Just Audio'),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () async {
                  await _justAudioPlayer.setUrl(audio);
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
                  await _mediaKitPlayer.open(Media(audio));
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
