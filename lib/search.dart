import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/videopages/Vvideopage9.dart';
import 'package:mehmetcanmovies/videopages/videopage1.dart';
import 'package:mehmetcanmovies/videopages/videopage10.dart';
import 'package:mehmetcanmovies/videopages/videopage2.dart';
import 'package:mehmetcanmovies/videopages/videopage4.dart';
import 'package:mehmetcanmovies/videopages/videopage5.dart';
import 'package:mehmetcanmovies/videopages/videopage6.dart';
import 'package:mehmetcanmovies/videopages/videopage7.dart';
import 'package:mehmetcanmovies/videopages/videopage8.dart';

class Search extends StatefulWidget {
  const Search({Key? key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Map<String, dynamic>> _all = [
    {"id": 1, "isim": "X-MEN", "lokasyon": "FANTASTIC"},
    {"id": 2, "isim": "NARNIA", "lokasyon": "SCIENCE FICTION"},
    {"id": 3, "isim": "AFTER", "lokasyon": "ROMANTIC"},
    {"id": 4, "isim": "PIRATES OF THE CARIBBEAN", "lokasyon": "FANTASTIC"},
    {"id": 5, "isim": "THE PURGE", "lokasyon": "FANTASTIC"},
    {"id": 7, "isim": "SPIDERMAN", "lokasyon": "SCIENCE FICTION"},
    {"id": 8, "isim": "HOBBIT", "lokasyon": "FANTASTIC"},
    {"id": 9, "isim": "JOHN CARTER", "lokasyon": "FANTASTIC"},
    {"id": 10, "isim": "BAYWATCH", "lokasyon": "ADVENTURE"},
  ];

  List<Map<String, dynamic>> _founder = [];

  @override
  void initState() {
    _founder = _all;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _all;
    } else {
      results = _all
          .where((user) =>
              user["isim"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _founder = results;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    labelText: "search", suffixIcon: Icon(Icons.search)),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _founder.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey(_all[index]["id"]),
                    color: Color.fromARGB(255, 57, 55, 55),
                    elevation: 4,
                    margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Text(
                        _founder[index]["id"].toString(),
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 33),
                        child: Text(
                          _founder[index]["isim"],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 33),
                        child: Text(
                          "${_founder[index]["lokasyon"].toString()}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        if (_founder[index]["id"] == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen7(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen10(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen4(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen8(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen2(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 6) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen5(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 7) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 8) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen6(),
                            ),
                          );
                        } else if (_founder[index]["id"] == 9) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen9(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
