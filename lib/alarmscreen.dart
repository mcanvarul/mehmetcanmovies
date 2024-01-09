import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmState();
}

DateTime? _selectedDateTime;

class _AlarmState extends State<AlarmScreen> {
  Future setAlarm(String title, String body) async {
    final alarmSettings = AlarmSettings(
        id: 46,
        dateTime: _selectedDateTime!,
        assetAudioPath: 'assets/alarm.mp3',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: title,
        notificationBody: body,
        enableNotificationOnKill: true,
        androidFullScreenIntent: true);
    Alarm.set(alarmSettings: alarmSettings);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Alarm'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          children: [
            Container(
              color: Colors.red,
              child: TextButton(
                  onPressed: () async {
                    _selectedDateTime = await showOmniDateTimePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime(1600).subtract(const Duration(days: 3652)),
                      lastDate: DateTime.now().add(
                        const Duration(days: 3652),
                      ),
                      is24HourMode: true,
                      isShowSeconds: false,
                      minutesInterval: 1,
                      secondsInterval: 1,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      constraints: const BoxConstraints(
                        maxWidth: 350,
                        maxHeight: 650,
                      ),
                      barrierDismissible: true,
                      selectableDayPredicate: (dateTime) {
                        // Disable 25th Feb 2023
                        if (dateTime == DateTime(2023, 2, 25)) {
                          return false;
                        } else {
                          return true;
                        }
                      },
                    );
                    setState(() {
                      _selectedDateTime = _selectedDateTime;
                    });
                    if (_selectedDateTime != null) {
                      print(_selectedDateTime);
                      await setAlarm("Hobbit", "Alarm");
                      await cancelAlarm();
                      // when alarm calling stop the alarm
                      // Alarm.stop(46);
                      // write the function
                    }
                  },
                  child: Text(
                    'Alarm',
                    style: TextStyle(color: Colors.white, fontSize: 64),
                  )),
            ),
            Container(
              color: Colors.blue,
              child: Text('Alarm'),
            ),
            Container(
              color: Colors.red,
              child: Text('Alarm'),
            ),
            Container(
              color: Colors.blue,
              child: Text('Alarm'),
            ),
          ],
        ));
  }
}
