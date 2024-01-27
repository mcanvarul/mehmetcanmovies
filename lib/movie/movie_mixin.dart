import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/movie/comment_model.dart';
import 'package:mehmetcanmovies/movie/movie_view.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fireStore;

mixin MovieViewMixin on State<MovieView> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  List<CommentModel> comments = [];
  final _auth = FirebaseAuth.instance;
  TextEditingController commentController = TextEditingController();
  late User userCredential;
  @override
  void initState() {
    userCredential = FirebaseAuth.instance.currentUser!;
    videoPlayerController =
        VideoPlayerController.network(widget.movieListModel.url ?? "");
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        showControls: true,
        allowFullScreen: true,
        autoInitialize: true,
        showControlsOnInitialize: true,
        aspectRatio: 16 / 9);
    getComments();
    super.initState();
  }

  Future<void> addComment() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print(user.email);
        print(user.refreshToken);
        await fireStore.FirebaseFirestore.instance
            .collection("comments")
            .doc("${user.displayName}${DateTime.now()}")
            .set({
          "movie_name": widget.movieListModel.name,
          "comment": commentController.text,
          "user_name": user.displayName,
          "created_date": DateTime.now(),
        }, fireStore.SetOptions(merge: true));
        getComments();
        commentController.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getComments() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('comments')
          .where("movie_name", isEqualTo: widget.movieListModel.name)
          .get();
      comments = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          CommentModel talep = CommentModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          setState(() {
            comments.add(talep);
          });
        }
        print("***********************************");

        print('Talepler: $comments');
      } else {
        print("***********************************");

        print('Belge bulunamadı.');
      }
    } catch (e) {
      print("***********************************");

      print('Veri çekme hatası: $e');
    }
  }

  Future<void> deleteMovie(BuildContext context) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('movies')
          .where("name", isEqualTo: widget.movieListModel.name)
          .get();
      comments = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference.delete();
        }
        print("***********************************");

        print('Talepler: $comments');
      } else {
        print("***********************************");

        print('Belge bulunamadı.');
      }
    } catch (e) {
      print("***********************************");

      print('Veri çekme hatası: $e');
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
