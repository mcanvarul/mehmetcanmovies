import 'package:flutter/material.dart';
import 'package:mehmetcanmovies/admin/admin_view_mixin.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> with AdminViewMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
          constraints: constraints,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            body: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10),
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      await _dialogBuilder(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Movie")),
                ElevatedButton.icon(
                    onPressed: () async {
                      await _alarmDialogBuilder(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Alarm")),
              ],
            ),
          )),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Basic dialog title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: movieNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter The Movie Name',
                  ),
                ),
                TextField(
                  controller: movieDescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter The Movie Description',
                  ),
                ),
                TextField(
                  controller: movieCategoryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter The Movie Category',
                  ),
                ),
                TextField(
                  controller: movieDirectorController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Director',
                  ),
                ),
                TextField(
                  controller: movieActorsController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter The Movie Actors',
                  ),
                ),
                TextField(
                  controller: movieRatingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter The movie score',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add Movie'),
              onPressed: () {
                selectVideo();
              },
            ),
            TextButton(
              child: Text('Add Image'),
              onPressed: () {
                selecetImage();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                loadMovie();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _alarmDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alarm dialog title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: alarmNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter The Movie Name',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await selectAlarm();
                    },
                    child: Text("Select Alarm Image")),
                ElevatedButton(
                    onPressed: () async {
                      await addAlarm();
                      await loadAlarm();
                      Navigator.of(context).pop();
                    },
                    child: Text("Save")),
                ElevatedButton.icon(
                    onPressed: () async {
                      alarmDate = (await showOmniDateTimePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1600)
                                .subtract(const Duration(days: 3652)),
                            lastDate: DateTime.now().add(
                              const Duration(days: 3652),
                            ),
                            is24HourMode: true,
                            isShowSeconds: false,
                            minutesInterval: 1,
                            secondsInterval: 1,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
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
                    },
                    icon: Icon(Icons.alarm),
                    label: Text("Hatırlatma Ayarla"))
              ],
            ),
          ),
        );
      },
    );
  }
}
