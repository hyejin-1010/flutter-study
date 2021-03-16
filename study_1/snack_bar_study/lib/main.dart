import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MySnackBar() ,
  ));
}

class MySnackBar extends StatefulWidget {
  @override
  _MySnackBarState createState() => _MySnackBarState();
}

class _MySnackBarState extends State<MySnackBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snack Bar'),
      ),
      body: Builder(builder: (context) => Center(
        child: RaisedButton(
          onPressed: () {
            final snackbar = SnackBar(
              content: Text('It is SnackBar'),
              action: SnackBarAction(
                label: 'Cancel',
                onPressed: () {
                },
              ),
            );
            Scaffold.of(context).showSnackBar(snackbar);
          },
          child: Text('Show SnackBar'),
        ),
      ))
    );
  }
}