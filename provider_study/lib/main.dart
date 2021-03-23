import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_study/src/home.dart';
import 'package:provider_study/src/provider/count_provider.dart';

// 참고: https://www.youtube.com/watch?v=AmmjdvhQG1s

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        // 이를 통해 Child(Home) 에 있는 모든 Widget 들은 CountProvider 에 접근할 수 있다.
        create: (BuildContext context) => CountProvider(),
        child: Home(),
      ),
    );
  }
}


