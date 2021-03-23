import 'package:flutter/material.dart';
import 'package:widget_study/rabbit.dart';
import 'package:widget_study/stateful_sample_widget.dart';
import 'package:widget_study/stateless_sample_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StatefulSampleWidget(
        title: "구멍이 있는 박스로 실험하는 자",
        rabbit: Rabbit(name: "토끼", state: RabbitState.SLEEP),
      )
      /*
      home: StatelessSampleWidget(
        title: "구멍이 없는 박스로 실험하는 자",
        rabbit: Rabbit(name: "토끼", state: RabbitState.SLEEP),
      )
      */
    );
  }
}
