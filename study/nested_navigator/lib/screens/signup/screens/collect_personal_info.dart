import 'package:flutter/material.dart';

class CollectPersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collect Personal Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Collect Credentials'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'signup/credentials');
              },
            )
          ],
        ),
      ),
    );
  }
}
