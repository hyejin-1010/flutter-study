import 'package:analog_clock/providers/my_theme_provider.dart';
import 'package:analog_clock/screens/home.dart';
import 'package:analog_clock/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 참고: https://www.youtube.com/watch?v=u6Cfzng3Gek

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyThemeModel(),
      child: Consumer<MyThemeModel>(
        builder: (BuildContext context, MyThemeModel theme, Widget? child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            home: Home(),
          );
        },
      ),
    );
  }
}
