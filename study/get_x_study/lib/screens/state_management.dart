import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_study/screens/on_update.dart';
import 'package:get_x_study/screens/reactive.dart';

class StateManagement extends StatefulWidget {
  const StateManagement({Key? key}) : super(key: key);

  @override
  _StateManagementState createState() => _StateManagementState();
}

class _StateManagementState extends State<StateManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX State Management'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.to(OnUpdateScreen());
              },
              child: Text('On Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(ReactiveScreen());
              },
              child: Text('Reactive'),
            ),
          ],
        ),
      ),
    );
  }
}
