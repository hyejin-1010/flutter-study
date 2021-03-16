import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Page1(),
  ));
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // return child;
      // Animation - 아래에서 위로
      var begin = Offset(0.0, 1.0); // Offset(1.0, 0.0); - 우에서 좌로
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var curve = Curves.ease;
      var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
      // var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    }
  );
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}


