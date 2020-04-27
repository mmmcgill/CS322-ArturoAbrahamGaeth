import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectbusywork/myColors.dart';
import 'home_widget.dart';
import 'tasks.dart';
import 'package:intl/intl.dart';

class NewActivityWidget extends StatefulWidget {
  @override
  NewActivityState createState() => NewActivityState();
}

class NewActivityState extends State<NewActivityWidget> {
  final titleKey = GlobalKey<FormState>();
  final locationKey = GlobalKey<FormState>();
  final descriptionKey = GlobalKey<FormState>();
  final dateKey = GlobalKey<FormState>();
  final timeKey = GlobalKey<FormState>();
  final routineKey = GlobalKey<FormState>();
  String title, location, description, date, time, routine;
  bool check = false;
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime1 = DateTime.now();
  DateTime selectedTime2 = DateTime.now().add(Duration(minutes: 30));
  final DateFormat dated = DateFormat('yyyy-MM-dd');
  final DateFormat timed = DateFormat('HH : mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreen,
      body: SafeArea(
        child: ListView(
          primary: false,
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("New Activity", style: TextStyle(fontSize: 24)),
                RaisedButton(
                  child: Text('Back'),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0)),
                  color: hGreen,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Title: ', style: TextStyle(fontSize: 22)),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: titleKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child: TextFormField(
                              cursorColor: hGreen,
                              validator: (input) => input.length < 1
                                  ? 'Please insert title.'
                                  : null,
                              onSaved: (input) => title = input,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Location: ', style: TextStyle(fontSize: 22)),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: locationKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child: TextFormField(
                              cursorColor: hGreen,
                              validator: (input) => input.length < 1
                                  ? 'Please insert location.'
                                  : null,
                              onSaved: (input) => location = input,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Description: ', style: TextStyle(fontSize: 22)),
                Container(width: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: descriptionKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child: TextFormField(
                              cursorColor: hGreen,
                              validator: (input) => input.length < 1
                                  ? 'Please insert description.'
                                  : null,
                              onSaved: (input) => description = input,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Date: ', style: TextStyle(fontSize: 22)),
                Container(width: 20),
                Column(
                  children: <Widget>[
                    Text(dated.format(selectedDate)),
                    RaisedButton(
                      child: Text("Select Date"),
                      color: hGreen,
                      onPressed: () async {
                        final selectedDate = await selectDate(context);
                        if (selectedDate == null) return;

                        setState(
                          () {
                            this.selectedDate = DateTime(selectedDate.year,
                                selectedDate.month, selectedDate.day);
                          },
                        );
                      },
                    ),
                  ],
                ),
                Container(width: 20),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Time: ', style: TextStyle(fontSize: 22)),
                Container(width: 20),
                Column(
                  children: <Widget>[
                    Text(timed.format(selectedTime1)),
                    RaisedButton(
                      child: Text("Select Start \nTime"),
                      color: hGreen,
                      onPressed: () async {
                        final selectedTime1 = await selectTime(context);
                        if (selectedTime1 == null) return;

                        setState(
                          () {
                            this.selectedTime1 = DateTime(
                                selectedTime1.hour, selectedTime1.minute);
                          },
                        );
                      },
                    ),
                  ],
                ),
                Container(width: 20),
                Column(
                  children: <Widget>[
                    Text(timed.format(selectedTime2)),
                    RaisedButton(
                      child: Text("Select Finish\nTime"),
                      color: hGreen,
                      onPressed: () async {
                        final secondSelectedTime = await selectTime(context);
                        if (secondSelectedTime == null) return;

                        setState(
                          () {
                            selectedTime2 = DateTime(secondSelectedTime.hour,
                                secondSelectedTime.minute);
                          },
                        );
                      },
                    ),
                  ],
                ),
                Container(width: 20),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Routine: ', style: TextStyle(fontSize: 22)),
                Container(width: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: routineKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child: TextFormField(
                              cursorColor: hGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                child: Text('Create New Activity'),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                color: hGreen,
                onPressed: () {
                  submit();
                  if (check) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                    check = false;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime> selectDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
      );

  Future<TimeOfDay> selectTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
  }

  void submit() {
    if (titleKey.currentState.validate() &&
        locationKey.currentState.validate() &&
        descriptionKey.currentState.validate()) {
      titleKey.currentState.save();
      locationKey.currentState.save();
      descriptionKey.currentState.save();
      check = true;
      print(title);
    }
  }
}
