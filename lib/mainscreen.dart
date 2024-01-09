import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/alarmscreen.dart';
import 'package:mehmetcanmovies/profil/profil.dart';
import 'package:mehmetcanmovies/videopages/Vvideopage9.dart';
import 'package:mehmetcanmovies/videopages/videopage1.dart';
import 'package:mehmetcanmovies/videopages/videopage10.dart';
import 'package:mehmetcanmovies/videopages/videopage11.dart';
import 'package:mehmetcanmovies/videopages/videopage12.dart';
import 'package:mehmetcanmovies/videopages/videopage13.dart';
import 'package:mehmetcanmovies/videopages/videopage14.dart';
import 'package:mehmetcanmovies/videopages/videopage15.dart';
import 'package:mehmetcanmovies/videopages/videopage16.dart';
import 'package:mehmetcanmovies/videopages/videopage2.dart';
import 'package:mehmetcanmovies/videopages/videopage3.dart';
import 'package:mehmetcanmovies/videopages/videopage4.dart';
import 'package:mehmetcanmovies/videopages/videopage5.dart';
import 'package:mehmetcanmovies/videopages/videopage6.dart';
import 'package:mehmetcanmovies/videopages/videopage7.dart';
import 'package:mehmetcanmovies/videopages/videopage8.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: go(),
          ),
        ));
  }
}

class go extends StatefulWidget {
  const go({super.key});

  @override
  State<go> createState() => _goState();
}

class _goState extends State<go> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "MOVIES",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlarmScreen()),
                );
              },
              icon: Icon(Icons.alarm)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                icon: Icon(Icons.person)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            list(),
            list1(),
            list2(),
            list3(),
            list4(),
            list5(),
            list6(),
            list7(),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  list() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/hobbit.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen2()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/thepurge.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  list1() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen3()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/scream.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen4()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/after.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  list2() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen5()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/spiderman.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen6()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/john.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  list3() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen7()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/xmen.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen8()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/karayipkorsan.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  list4() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen9()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/baywatch.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen10()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/narnia.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  list5() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen11()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/johnwick.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen12()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/abouttime.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  list6() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen13()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/Deadpool.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen14()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/dontbreathee.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  list7() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen15()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/rednotice.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VideoScreen16()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            height: 230,
            width: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/aquaman.jpg")),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.3, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
