import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_study/rabbit.dart';
import 'package:widget_study/stateful_sample_widget.dart';
import 'package:widget_study/stateless_sample_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _value = 0;
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _value++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _value < 2 ? StatefulSampleWidget(
        title: "구멍이 있는 박스로 실험하는 자",
        value: _value,
        rabbit: Rabbit(name: "토끼", state: RabbitState.SLEEP),
      ) : Container()
      /*
      home: StatelessSampleWidget(
        title: "구멍이 없는 박스로 실험하는 자",
        rabbit: Rabbit(name: "토끼", state: RabbitState.SLEEP),
      )
      */
    );
  }
}
