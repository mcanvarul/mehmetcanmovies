import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoScreen14 extends StatefulWidget {
  @override
  _VideoScreen14State createState() => _VideoScreen14State();
}

class _VideoScreen14State extends State<VideoScreen14> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/mehmetcanmovies.appspot.com/o/dontbreathe.mp4?alt=media&token=430df89f-8143-4ed5-ad97-1b75881e5b15');

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        showControls: true,
        allowFullScreen: true,
        aspectRatio: 16 / 9);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1 / 3,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1 / 16,
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "DONT BREATHE - TRAILER",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 300, top: 40),
            child: Text(
              "Description:",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 5 / 16,
              child: Text(
                "Don't breathe is a gripping thriller that revolves around three young burglars who break into the house of a blind man, thinking it will be an easy target. However, they soon discover that the blind man is not as helpless as he seems. As they navigate through the dark and terrifying house, they realize they are trapped in a deadly game of cat and mouse. With intense suspense and unexpected twists, Don't Breathe keeps viewers on the edge of their seats until the very end.",
                style: TextStyle(color: Colors.white, fontSize: 13.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
