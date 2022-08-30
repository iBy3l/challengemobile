import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/content_model.dart';
import '../services/content_service_impl.dart';

class AudioController extends BlocBase {
  final content = ContentServiceImpl;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  AudioController(super.state);

  @override
  void controller() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.PLAYING;
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      position = newPosition;
    });
  }

  Future savePosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      position = newPosition;
      prefs.setInt('position', position.inSeconds);
    });
  }

  Future<ContentModel> setAudio() async {
    final content = await ContentServiceImpl().getContent();
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    String url = content.audio;
    audioPlayer.setUrl(url);
    return content;
  }
}
