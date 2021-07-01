import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_study/controller/builder_controller.dart';

class ReactiveScreen extends StatefulWidget {
  const ReactiveScreen({Key? key}) : super(key: key);

  @override
  _ReactiveScreenState createState() => _ReactiveScreenState();
}

class _ReactiveScreenState extends State<ReactiveScreen> {
  final controller = Get.put(ReactiveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactive'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GetX<ReactiveController>(
              // init: ReactiveController(),
              builder: (_) {
                return Text('Count 1 : ${_.count1.value}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Get.find<ReactiveController>().count1++;
                controller.count1++;
              },
              child: Text('+'),
            ),
            Obx(() {
              return Text('Count 2 : ${controller.count2.value}');
            }),
            ElevatedButton(
              onPressed: () {
                // Get.find<ReactiveController>().count1++;
                controller.count2++;
              },
              child: Text('+'),
            ),
            Obx(() {
              return Text('SUM : ${controller.sum}');
            }),
            Obx(() {
              return Text('USER : ${controller.user.value.id} / ${controller.user.value.name}');
            }),
            ElevatedButton(
              onPressed: () {
                controller.change(id: 2, name: '뿌요');
              },
              child: Text('Change User'),
            ),
            Obx(() {
              return Text('Count 2 : ${controller.testList}');
            }),
          ],
        ),
      ),
    );
  }
}
