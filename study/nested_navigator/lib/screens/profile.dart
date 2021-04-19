import 'package:flutter/material.dart';

import 'change_password.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text('Change Password'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ChangePasswordPage();
              }),
            );
          },
        ),
      ),
    );
  }
}
