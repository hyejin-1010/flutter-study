import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Home'),
            ElevatedButton(
              child: Text('Sign Up'),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
            ElevatedButton(
              child: Text('Profile'),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            )
          ],
        ),
      ),
    );
  }
}
