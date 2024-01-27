import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/main/movie_list_model.dart';
import 'package:mehmetcanmovies/movie/movie_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class MovieView extends StatefulWidget {
  MovieView({super.key, required this.movieListModel});
  MovieListModel movieListModel;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> with MovieViewMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: userCredential.email == "admin@admin.com"
            ? AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      deleteMovie(context);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1 / 3,
                  child: Chewie(
                    controller: chewieController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      Future<SharedPreferences> prefs0 =
                          SharedPreferences.getInstance();
                      final SharedPreferences prefs = await prefs0;
                      List<String>? list =
                          prefs.getStringList("watchedMovies") ?? [];
                      if (list.length > 1) {
                        list.removeAt(0);
                      }
                      await prefs.setStringList("watchedMovies",
                          [...list, widget.movieListModel.category!]);
                      print("*******************************");
                      print(prefs.getStringList("watchedMovies")?.length);
                      print(prefs.getStringList("watchedMovies")![0]);
                      print(prefs.getStringList("watchedMovies")![1]);
                      print("*******************************");
                      launchUrlString("https://www.netflix.com/tr/",
                          mode: LaunchMode.inAppBrowserView);
                    },
                    child:
                        Text("${widget.movieListModel.name ?? ""} - Trailer"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  widget.movieListModel.description ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          "FILM ACTORS:  ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        ...widget.movieListModel.actors!
                            .map((e) => Text(
                                  "$e, ",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        "FILM DIRECTORS:  ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        widget.movieListModel.director ?? "",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "IMBD:  ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "${widget.movieListModel.score ?? ""}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(comments[index].userName ?? ""),
                        subtitle: Text(comments[index].comment ?? ""),
                        trailing: Text(
                            comments[index].createdDate?.toDate().toString() ??
                                ""),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "Comment",
                      suffixIcon: IconButton(
                        onPressed: () {
                          addComment();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
