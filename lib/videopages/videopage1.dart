import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:mehmetcanmovies/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fireStore;

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _auth = FirebaseAuth.instance;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  final TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> requests = [];

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
    firebaseRequestInfo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () async {
            final SharedPreferences prefs = await _prefs;
            (prefs.getString('category') ??
                Category.action.name); // chose category

            launchUrlString(
                "https://www.youtube.com/watch?v=Jne9t8sHpUc&ab_channel=MovieclipsTrailers",
                mode: LaunchMode.inAppBrowserView);
          }),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1 / 3,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1 / 16,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  "HOBBIT - TRAILER",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 300, top: 40),
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
                child: const Text(
                  "It's about a team of dwarves led by Bilbo Baggins and Thorin Oakenshield confronting the dragon Smaug to retrieve the lost treasures of Erebor. Bilbo and the dwarves embark on an adventurous journey through the wastelands as they encounter various dangers including orcs, giant spiders and the inhabitants of Laketown. Confronted with the wrath and power of Smaug, Bilbo takes on the arduous task of helping his team achieve their goal and re-establish the kingdom of Erebor.",
                  style: TextStyle(color: Colors.white, fontSize: 13.5),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    requests[index]["user"],
                    style: const TextStyle(color: Colors.white24),
                  ),
                  subtitle: Text(
                    requests[index]["comment"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    "${requests[index]["date"].toDate().day}/${requests[index]["date"].toDate().month}/${requests[index]["date"].toDate().year}",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
              itemCount: requests.length,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Yorumunuzu giriniz",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Yorum",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                controller: commentController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ElevatedButton(
                onPressed: () {
                  firebaseAddRequest(commentController, context);
                },
                child: const Text("Gönder"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> firebaseAddRequest(
    commentController,
    context,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print(user.email);
        print(user.refreshToken);
        await fireStore.FirebaseFirestore.instance
            .collection("Comments")
            .doc("${user.displayName}${DateTime.now()}")
            .set({
          "movie": "Hobbit",
          "comment": commentController.text,
          "user": user.displayName,
          "date": DateTime.now(),
        }, fireStore.SetOptions(merge: true));
        firebaseRequestInfo();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> firebaseRequestInfo() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      QuerySnapshot querySnapshot = await firestore
          .collection('Comments')
          .where("movie", isEqualTo: "Hobbit")
          .get();
      requests = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> talep =
              documentSnapshot.data() as Map<String, dynamic>;
          setState(() {
            requests.add(talep);
          });
        }

        print('Talepler: $requests');
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }
}
