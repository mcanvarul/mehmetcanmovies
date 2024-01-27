import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                      crossAxisCount: 1,
                      childAspectRatio: 2,
                      mainAxisSpacing: 31),
                  itemCount: alarms.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 17),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(alarms[index].imageUrl ??
                                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.123rf.com%2Fphoto_104524510_stock-vector-no-image-available-icon-flat-vector-illustration.html&psig=AOvVaw0QZ3Z4Z4Z4Z4Z4Z4Z4Z4Z4&ust=1634177229124000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJjQ4ZqH0_MCFQAAAAAdAAAAABAD"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                alarms[index].movieName ?? "Başlık yok",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              Text(DateFormat('dd-MM-yyyy')
                                      .format(alarms[index].date?.toDate() ??
                                          DateTime.now())
                                      .toString() ??
                                  "Açıklama yok"),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: ElevatedButton(
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                    child: Text("Alarm")),
                              )
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
