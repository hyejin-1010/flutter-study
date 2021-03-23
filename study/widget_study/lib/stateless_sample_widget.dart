import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_study/rabbit.dart';

class StatelessSampleWidget extends StatelessWidget {

  final String title;
  final Rabbit rabbit;

  StatelessSampleWidget({
    Key key,
    this.title,
    this.rabbit
  }) : super(key: key) {
    Timer.periodic(Duration(seconds: 5), (timer) {
      print(timer.tick);
      int index = timer.tick % 4;
      switch (index) {
        case 0:
          rabbit.updateState(RabbitState.SLEEP);
          break;
        case 1:
          rabbit.updateState(RabbitState.WALK);
          break;
        case 2:
          rabbit.updateState(RabbitState.RUN);
          break;
        case 3:
          rabbit.updateState(RabbitState.EAT);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Center(
          child: Text(
            rabbit.state.toString(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
