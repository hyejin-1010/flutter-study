import 'package:flutter/material.dart';
import 'package:nested_navigator/screens/home.dart';
import 'package:nested_navigator/screens/profile.dart';
import 'package:nested_navigator/screens/settings.dart';
import 'package:nested_navigator/screens/signup/signup.dart';

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
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/signup': (BuildContext context) => SignupPage(),
        '/settings': (BuildContext context) => SettingsPage(),
        '/profile': (BuildContext context) => ProfilePage(),
      },
    );
  }
}
