import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoScreen16 extends StatefulWidget {
  @override
  _VideoScreen16State createState() => _VideoScreen16State();
}

class _VideoScreen16State extends State<VideoScreen16> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/mehmetcanmovies.appspot.com/o/aquaman.mp4?alt=media&token=68482347-3894-4905-8a15-9328fecc9d0e');

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
                "AQUAMAN - TRAILER",
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
                " Aquaman is an action-packed superhero film centered around the titular character, Arthur Curry, who must embrace his Atlantean heritage and reclaim his rightful place as the ruler of the underwater kingdom. With breathtaking visuals and thrilling underwater sequences, the film takes audiences on an epic journey as Aquaman battles his half-brother Orm to protect both the ocean and the surface world..",
                style: TextStyle(color: Colors.white, fontSize: 13.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
