import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mehmetcanmovies/login/login_view.dart';
import 'package:mehmetcanmovies/main/main_view.dart';
import 'package:mehmetcanmovies/sign_up/sign_up_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 17, 17),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainView()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Color.fromARGB(255, 38, 37, 37),
          title: Text("MOVIESAPP"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
                margin: EdgeInsets.only(top: 40),
                height: MediaQuery.of(context).size.height * 1 / 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 38, 37, 37),
                ),
                child: Center(
                  child: _user != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 220),
                              child: Text(
                                'My Account :',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 35),
                              child: Text(
                                'Username :  ${_user!.displayName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                'Email :  ${_user!.email}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: _signOut,
                                  child: Text(
                                    "Sign Out     /",
                                    style: TextStyle(),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _deleteAccount,
                                  child: Text(
                                    "Delete Account",
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 256, top: 30),
              child: Text(
                "MovıesApp :",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "İmproves the movie discovery and viewing experience by offering movie lovers a large movie archive.Users can explore popular movies, trailers and detailed movie descriptions ad-free through the app.With its user-friendly interface, the application aims to provide a pleasant experience to movie lovers.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void _deleteAccount() async {
    try {
      await _user!.delete();
      print("Account deleted successfully.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpView()),
      );
    } catch (e) {
      print(e);
    }
  }
}
