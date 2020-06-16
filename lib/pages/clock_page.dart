import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key key}) : super(key: key);

  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  String days, hours, minutes, period;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
          child: new Material(
            color: Colors.white,
            child: TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
              updateTime();
              return Text(
                hours + ":" + minutes + period + " Day " + days,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              );
            }),
          )
      )
    );
  }

  void updateTime(){
    DateTime now = DateTime.now().toUtc();

    int igTotalMinutes = now.hour * 3600 + now.minute * 60 + now.second;
    int igTotalHours = igTotalMinutes ~/ 60;
    int igDays = igTotalHours ~/ 24 + 1;
    int igHours = igTotalHours % 24;
    int igMinutes = igTotalMinutes - igHours * 60 - (igDays - 1) * 1440;
    if(igDays > 30) igDays -= 30;
    days = igDays.toString();
    minutes = ("0" + igMinutes.toString());
    minutes = minutes.substring(minutes.length - 2, minutes.length);
    period = "am";
    if(igHours >= 12) period = "pm";
    if(igHours > 12) igHours -= 12;
    hours = "0" + igHours.toString();
    hours = hours.substring(hours.length - 2, hours.length);
  }
}