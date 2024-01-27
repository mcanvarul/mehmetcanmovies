import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/alarm/alarm_model.dart';
import 'package:mehmetcanmovies/alarm/alarm_view.dart';

mixin AlarmViewMixin on State<AlarmView> {
  List<AlarmModel> alarms = [];
  late User userCredential;
  DateTime alarmDate = DateTime.now();

  Future<void> fetchAlarms() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      QuerySnapshot querySnapshot = await firestore.collection('alarms').get();
      alarms = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          AlarmModel talep = AlarmModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          setState(() {
            alarms.add(talep);
          });
        }

        print('Talepler: $alarms');
      } else {
        print('Belge bulunamadı.');
      }
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  Future<void> deleteAlarm(BuildContext context, AlarmModel alarm) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('alarms')
          .where("movie_name", isEqualTo: alarm.movieName)
          .get();
      alarms = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference.delete();
        }
        print("***********************************");

        print('Talepler: $alarms');
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

  Future setAlarm(String alarm) async {
    final alarmSettings = AlarmSettings(
        id: 46,
        dateTime: alarmDate,
        assetAudioPath: 'assets/alarm.mp3',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: alarm,
        notificationBody: "Alarm",
        enableNotificationOnKill: true,
        androidFullScreenIntent: true);
    await Alarm.set(alarmSettings: alarmSettings);
    cancelAlarm();
  }

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
