import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Two'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () { Get.back(); },
            child: Text('Back'),
          ),
        ),
      ),
    );
  }
}
