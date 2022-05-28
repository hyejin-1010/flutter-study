import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // TODO: 인스타 피드, 상품권 추가 3D, 3D Layer Card
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('3일 지난 인스타 피드'),
          ),
        ],
      ),
    );
  }
}
