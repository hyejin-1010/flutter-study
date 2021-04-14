import 'dart:async';
import 'package:analog_clock/size_config.dart';
import 'package:flutter/material.dart';

class TimeInHourAndMinute extends StatefulWidget {
  @override
  _TimeInHourAndMinuteState createState() => _TimeInHourAndMinuteState();
}

class _TimeInHourAndMinuteState extends State<TimeInHourAndMinute> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      TimeOfDay _now = TimeOfDay.now();
      if (_timeOfDay.minute != _now.minute) {
        setState(() {
          _timeOfDay = _now;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${_timeOfDay.hourOfPeriod}:${_timeOfDay.minute}',
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(width: 5),
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            _period,
            style: TextStyle(fontSize: getProportionateScreenWidth(18)),
          ),
        ),
      ],
    );
  }
}
