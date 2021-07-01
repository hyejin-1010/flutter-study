import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenFour extends StatefulWidget {
  const ScreenFour({Key? key}) : super(key: key);

  @override
  _ScreenFourState createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Four'),
      ),
      body: Container(
        child: Center(
          child: Text(Get.arguments),
        ),
      ),
    );
  }
}
