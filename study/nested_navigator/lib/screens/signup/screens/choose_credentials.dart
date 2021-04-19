import 'package:flutter/material.dart';

class ChooseCredentialsPage extends StatelessWidget {
  ChooseCredentialsPage({
    required this.onSignupCompleted,
  });
  final VoidCallback onSignupCompleted;

  Future<bool> didComplete(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Did you complete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      }
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Credentials'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Done'),
          onPressed: () async {
            final bool result = await didComplete(context);
            if (result) { onSignupCompleted(); }
          },
        ),
      ),
    );
  }
}
