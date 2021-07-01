import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_study/screens/screen_five.dart';
import 'package:get_x_study/screens/screen_four.dart';
import 'package:get_x_study/screens/screen_one.dart';
import 'package:get_x_study/screens/screen_three.dart';
import 'package:get_x_study/screens/screen_two.dart';
import 'package:get_x_study/screens/state_management.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => ScreenOne(),
        ),
        GetPage(
          name: '/two',
          page: () => ScreenTwo(),
        ),
        GetPage(
          name: '/three',
          page: () => ScreenThree(),
        ),
        GetPage(
          name: '/four',
          page: () => ScreenFour(),
        ),
        GetPage(
          name: '/five/:param',
          page: () => ScreenFive(),
        ),
      ],
      home: Scaffold(
        body: Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () { Get.to(StateManagement()); },
              child: Text('Go To State Management'),
            ),
          ),
        ),
      ),
    );
  }
}
