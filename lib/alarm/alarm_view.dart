import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/alarm/alarm_view_mixin.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> with AlarmViewMixin {
  @override
  void initState() {
    super.initState();
    userCredential = FirebaseAuth.instance.currentUser!;
    fetchAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: alarms.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: alarms.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            alarms[index].imageUrl ??
                                "https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(alarms[index].movieName ?? "Başlık yok"),
                              Text(alarms[index].date?.toDate().toString() ??
                                  "Açıklama yok"),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    alarmDate = (await showOmniDateTimePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1600).subtract(
                                              const Duration(days: 3652)),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 3652),
                                          ),
                                          is24HourMode: true,
                                          isShowSeconds: false,
                                          minutesInterval: 1,
                                          secondsInterval: 1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          constraints: const BoxConstraints(
                                            maxWidth: 350,
                                            maxHeight: 650,
                                          ),
                                          barrierDismissible: true,
                                          selectableDayPredicate: (dateTime) {
                                            // Disable 25th Feb 2023
                                            if (dateTime ==
                                                DateTime(2023, 2, 25)) {
                                              return false;
                                            } else {
                                              return true;
                                            }
                                          },
                                        )) ??
                                        DateTime.now();
                                    setState(() {
                                      alarmDate = alarmDate;
                                    });
                                    if (alarmDate != null) {
                                      print(alarmDate);
                                      //await setAlarm("Hobbit", "Alarm");
                                      //await cancelAlarm();
                                      // when alarm calling stop the alarm
                                      // Alarm.stop(46);
                                      // write the function
                                    }
                                    await setAlarm(alarms[index].movieName!);
                                  },
                                  icon: Icon(Icons.alarm),
                                  label: Text("Hatırlatma Ayarla"))
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ));
    });
  }
}
