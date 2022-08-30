import 'package:audioplayers/audioplayers.dart';
import 'package:challengemobile/models/content_model.dart';
import 'package:challengemobile/services/content_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentAudioPage extends StatefulWidget {
  const ContentAudioPage({Key? key}) : super(key: key);

  @override
  State<ContentAudioPage> createState() => _ContentAudioPageState();
}

class _ContentAudioPageState extends State<ContentAudioPage> {
  final content = ContentServiceImpl;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    savePosition();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });

      audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
          print('Posi $newPosition');
        });
      });
    });
  }

  void controller() async {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });

      audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
        });
      });
      audioPlayer.onAudioPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });
    });
  }

  Future savePosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
        prefs.setInt('position', position.inSeconds);
      });
    });
  }

  Future<ContentModel> setAudio() async {
    final content = await ContentServiceImpl().getContent();
    audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
    String url = content.audio;
    audioPlayer.setUrl(url);
    return content;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   audioPlayer.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff0F0F29),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff0F0F29),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://m.media-amazon.com/images/I/51drYBDrAvL.jpg',
                fit: BoxFit.cover,
                width: size.width * 0.8,
                height: size.height * 0.4,
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Column(
              children: [
                const Text(
                  'A Arte da Guerra',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                Slider(
                  activeColor: Colors.white,
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: ((value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);
                    await audioPlayer.resume();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(position),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        formatTime(duration - position),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: const Color(0xff0F0F29),
                      size: 32,
                    ),
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.resume();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(
        2,
        '0',
      );

  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final segunds = twoDigits(duration.inSeconds.remainder(60));
  return [
    if (duration.inHours > 0) hours,
    minutes,
    segunds,
  ].join(':');
}
