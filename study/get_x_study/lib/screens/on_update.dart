import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_study/controller/builder_controller.dart';

class OnUpdateScreen extends StatefulWidget {
  const OnUpdateScreen({Key? key}) : super(key: key);

  @override
  _OnUpdateScreenState createState() => _OnUpdateScreenState();
}

class _OnUpdateScreenState extends State<OnUpdateScreen> {
  final controller = Get.put(BuilderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Update'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('On Update'),
            GetBuilder<BuilderController>(
              // init: BuilderController(),
              builder: (_) {
                return Text('Count : ${_.count}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Get.find<BuilderController>().increment();
                controller.increment();
              },
              child: Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}
