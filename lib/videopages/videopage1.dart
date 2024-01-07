
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  
  final _auth = FirebaseAuth.instance;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/mehmetcanmovies.appspot.com/o/hobbit.mp4?alt=media&token=7fa7f4ba-0c4b-41ec-ad33-1c4d24471225');

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
                "HOBBIT - TRAILER",
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
                "It's about a team of dwarves led by Bilbo Baggins and Thorin Oakenshield confronting the dragon Smaug to retrieve the lost treasures of Erebor. Bilbo and the dwarves embark on an adventurous journey through the wastelands as they encounter various dangers including orcs, giant spiders and the inhabitants of Laketown. Confronted with the wrath and power of Smaug, Bilbo takes on the arduous task of helping his team achieve their goal and re-establish the kingdom of Erebor.",
                style: TextStyle(color: Colors.white, fontSize: 13.5),
              ),
            ),
          ),
         /*  TextFormField(
            controller: commentController,
          ),
          ElevatedButton(
              onPressed: () {
                firebaseAddRequest(commentController, context);
              },
              child: Text("Gönder")) */
        ],
      ),
    );
  }

 /*  Future<void> firebaseAddRequest(
    commentController,
    context,
  ) async {
    DateTime now = DateTime.now();
    String monthName = DateFormat('MMMM').format(now);
    try {
      _fireStore
          .collection("Comments")
          .doc(
              "comment ${_auth.currentUser!.email} ${now.minute}:${now.second}")
          .set({
        'dateMonth': monthName,
        'dateDay': now.day,
        'createMinute': now.minute,
        'createSecond': now.second,
        'userId': _auth.currentUser!.uid,
        'user': _auth.currentUser!.email,
        'comment': commentController.toString()
      });
      //Navigator.popAndPushNamed(context, '/screens/main_screen');
    } catch (e) {
      print('Veri yükleme hatası: $e');
    }
  } */
}
