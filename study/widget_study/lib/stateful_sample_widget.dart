import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_study/rabbit.dart';

class StatefulSampleWidget extends StatefulWidget {
  final String title;
  final Rabbit rabbit;

  StatefulSampleWidget({
    this.title,
    this.rabbit
  });

  @override
  _StatefulSampleWidgetState createState() => _StatefulSampleWidgetState();
}

class _StatefulSampleWidgetState extends State<StatefulSampleWidget> {
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      print(timer.tick);
      int index = timer.tick % 4;
      setState(() {
        switch (index) {
          case 0:
            widget.rabbit.updateState(RabbitState.SLEEP);
            break;
          case 1:
            widget.rabbit.updateState(RabbitState.WALK);
            break;
          case 2:
            widget.rabbit.updateState(RabbitState.RUN);
            break;
          case 3:
            widget.rabbit.updateState(RabbitState.EAT);
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Text(
            widget.rabbit.state.toString(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
