import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoScreen5 extends StatefulWidget {
  @override
  _VideoScreen5State createState() => _VideoScreen5State();
}

class _VideoScreen5State extends State<VideoScreen5> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/mehmetcanmovies.appspot.com/o/SPIDER-MAN_%20NO%20WAY%20HOME%20-%20Official%20Trailer%20(HD).mp4?alt=media&token=51aa87bb-ecab-493a-b3b6-c17be4f85205');

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
                "SPIDERMAN - TRAILER",
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
                "Spider-Man: No Way Home is an action-packed superhero film that follows Peter Parker as he grapples with the consequences of revealing his secret identity. When a spell gone wrong unleashes villains from other dimensions, Peter must team up with Doctor Strange to restore order and protect his loved ones. Packed with thrilling battles, emotional moments, and unexpected twists, Spider-Man: No Way Home takes audiences on a wild ride through the multiverse and sets the stage for an epic showdown.",
                style: TextStyle(color: Colors.white, fontSize: 13.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
