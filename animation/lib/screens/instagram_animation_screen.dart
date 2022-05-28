import 'package:animation/painters/insta_painter.dart';
import 'package:flutter/material.dart';

class InstagramScreen extends StatefulWidget {
  const InstagramScreen({Key? key}) : super(key: key);

  @override
  _InstagramScreenState createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () {
              _controller.reset();
              _controller.forward();
            },
            child: const Text('Start'),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            width: size.width,
            height: size.height - 100.0,
            child: CustomPaint(
              painter: InstaPainter(_controller.value),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
