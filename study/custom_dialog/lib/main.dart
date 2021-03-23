import 'package:custom_dialog/dialogs/custom_dialog_box.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Custom Dialog In Flutter"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Dialogs(),
      ),
    );
  }
}

class Dialogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Custom Dialog Demo",
                  descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                  text: "Yes",
                );
              },
            );
          },
          child: Text('Custom Dialog'),
        ),
      ),
    );
  }
}

