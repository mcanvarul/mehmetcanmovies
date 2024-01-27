import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/admin/admin_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fireStore;
import 'dart:io';

final _auth = FirebaseAuth.instance;

mixin AdminViewMixin on State<AdminView> {
  late File video;
  late File image;
  late String movieUrl;
  late String imageUrl;
  late File alarm;
  late String alarmUrl;
  TextEditingController movieNameController = TextEditingController();
  TextEditingController movieDescriptionController = TextEditingController();
  TextEditingController movieDirectorController = TextEditingController();
  TextEditingController movieActorsController = TextEditingController();
  TextEditingController movieCategoryController = TextEditingController();
  TextEditingController movieRatingController = TextEditingController();
  TextEditingController alarmNameController = TextEditingController();
  DateTime alarmDate = DateTime.now();

  Future<void> selectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        video = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> selecetImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        image = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> addMovie() async {
    try {
      var storage = FirebaseStorage.instance;
      String imageName = video.path.split('/').last;
      TaskSnapshot taskSnapshot = await storage.ref(imageName).putFile(video);

      movieUrl = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  Future<void> addImage() async {
    try {
      var storage = FirebaseStorage.instance;
      String imageName = image.path.split('/').last;
      TaskSnapshot taskSnapshot = await storage.ref(imageName).putFile(image);
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  Future<void> loadMovie() async {
    await addMovie();
    await addImage();
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print(user.email);
        print(user.refreshToken);
        await fireStore.FirebaseFirestore.instance
            .collection("movies")
            .doc("${user.displayName}${DateTime.now()}")
            .set({
          "id": "${user.displayName}${DateTime.now()}",
          "name": movieNameController.text,
          "description": movieDescriptionController.text,
          "director": movieDirectorController.text,
          "actors": [movieActorsController.text],
          "category": movieCategoryController.text,
          "score": movieRatingController.text,
          "url": movieUrl,
          "image_url": imageUrl,
        }, fireStore.SetOptions(merge: true));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> selectAlarm() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        alarm = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> addAlarm() async {
    try {
      var storage = FirebaseStorage.instance;
      String imageName = alarm.path.split('/').last;
      TaskSnapshot taskSnapshot = await storage.ref(imageName).putFile(alarm);

      alarmUrl = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  Future<void> loadAlarm() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print(user.email);
        print(user.refreshToken);
        await fireStore.FirebaseFirestore.instance
            .collection("alarms")
            .doc("${user.displayName}${DateTime.now()}")
            .set({
          "movie_name": alarmNameController.text,
          "image_url": alarmUrl,
          "date": Timestamp.fromDate(alarmDate),
        }, fireStore.SetOptions(merge: true));
      }
    } catch (e) {
      print(e);
    }
  }

/*   Future setAlarm() async {
    final alarmSettings = AlarmSettings(
        id: 46,
        dateTime: alarmDate,
        assetAudioPath: 'assets/alarm.mp3',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: alarmNameController.text,
        notificationBody: "Alarm",
        enableNotificationOnKill: true,
        androidFullScreenIntent: true);
    await Alarm.set(alarmSettings: alarmSettings);
  } */

  Future cancelAlarm() async {
    // Alarm.cancel(id: 46);
    bool isRunning = await Alarm.isRinging(46);
    if (isRunning) {
      await Future.delayed(Duration(seconds: 10));
      Alarm.stop(46);
    } else {
      cancelAlarm();
    }
  }
}
