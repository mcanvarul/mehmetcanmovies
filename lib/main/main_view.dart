import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/main/main_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with MainViewMixin {
  late User userCredential;
  @override
  void initState() {
    userCredential = FirebaseAuth.instance.currentUser!;
    fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchController.text.isEmpty ? fetchMovies() : filterMovies();
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await adviceMovie(context);
            },
            child: const Icon(Icons.play_arrow),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                alarmNavigation(context);
              },
              icon: const Icon(Icons.logout),
            ),
            actions: [
              userCredential.email == "admin@admin.com"
                  ? IconButton(
                      onPressed: () {
                        adminNavigation(context);
                      },
                      icon: const Icon(Icons.admin_panel_settings),
                    )
                  : Container(),
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) => searchController.text.isEmpty
                      ? fetchMovies()
                      : filterMovies(),
                  decoration: const InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              movieList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        fetchMovies();
                      },
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: movieList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              navigateToMovieView(movieList[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(movieList[index].imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ));
    });
  }
}
