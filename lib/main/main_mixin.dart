import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/admin/admin_view.dart';
import 'package:mehmetcanmovies/alarm/alarm_view.dart';
import 'package:mehmetcanmovies/main/main_view.dart';
import 'package:mehmetcanmovies/main/movie_list_model.dart';
import 'package:mehmetcanmovies/movie/movie_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin MainViewMixin on State<MainView> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  List<MovieListModel> movieList = [];
  List<String> category = [];
  MovieListModel? watchedMovies;

  void navigateToMovieView(MovieListModel movieListModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieView(
          movieListModel: movieListModel,
        ),
      ),
    );
  }

  Future<void> fetchMovies() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      QuerySnapshot querySnapshot = await firestore.collection('movies').get();
      movieList = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          MovieListModel talep = MovieListModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          setState(() {
            movieList.add(talep);
          });
        }

        print('Talepler: $movieList');
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  Future<void> filterMovies() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      QuerySnapshot querySnapshot = await firestore
          .collection('movies')
          .where('name', isEqualTo: searchController.text)
          .get();

      setState(() {
        movieList = [];
      });

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          MovieListModel talep = MovieListModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          setState(() {
            movieList.add(talep);
          });
        }

        print('Talepler: $movieList');
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  void adminNavigation(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AdminView(),
    ));
  }

  void alarmNavigation(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AlarmView(),
    ));
  }

  Future<void> adviceMovie(BuildContext ctx) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    setState(() {
      category = prefs.getStringList("watchedMovies") ?? [];
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    var rng = Random();
    QuerySnapshot querySnapshot = await firestore
        .collection('movies')
        .where('category', isEqualTo: category[rng.nextInt(category.length)])
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        MovieListModel talep = MovieListModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        setState(() {
          watchedMovies = talep;
        });
      }
      print('Talepler: $movieList');
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => MovieView(
            movieListModel: watchedMovies!,
          ),
        ),
      );
    } else {
      print('Belge bulunamadı.');
    }
  }
}
