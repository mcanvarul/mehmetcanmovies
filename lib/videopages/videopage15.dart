import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoScreen15 extends StatefulWidget {
  @override
  _VideoScreen15State createState() => _VideoScreen15State();
}

class _VideoScreen15State extends State<VideoScreen15> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/mehmetcanmovies.appspot.com/o/rednotice.mp4?alt=media&token=457063fa-9885-405f-ae81-42c89ab8b16d');

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
                "RED NOTICE - TRAILER",
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
                "Red notice is an action-packed heist film that centers around an Interpol agent who teams up with two rival criminals to track down and capture the world's most wanted art thief. As they embark on a globe-trotting adventure, they find themselves entangled in a thrilling game of cat and mouse, facing danger and deception at every turn. With its high-stakes plot and charismatic cast, Red Notice delivers non-stop excitement and unexpected twists.",
                style: TextStyle(color: Colors.white, fontSize: 13.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
