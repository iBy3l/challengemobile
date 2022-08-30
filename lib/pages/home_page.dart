import 'package:challengemobile/pages/content_audio_page.dart';
import 'package:flutter/material.dart';

import 'content_pdf_page.dart';
import 'content_video_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPdfPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Mobile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('pdf'),
              onPressed: () async {
                currentPdfPage = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContentPdfPage(
                      currentPdfPage: currentPdfPage,
                    ),
                  ),
                );
                // print(currentPdfPage);
              },
            ),
            ElevatedButton(
              child: const Text('Open Video'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContentVideoPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Open Audio'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContentAudioPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
