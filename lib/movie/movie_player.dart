import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  VideoPlayer(
      {required this.videoPlayerController,
      required this.autoplay,
      required this.looping,
      Key? key})
      : super(key: key);

  @override
  State<VideoPlayer> createState() => _videoState();
}

class _videoState extends State<VideoPlayer> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      aspectRatio: 6 / 4,
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Text("ERROR"),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(controller: _chewieController),
    );
  }
}
