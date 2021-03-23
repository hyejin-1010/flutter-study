import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScaffoldSample(),
    );
  }
}

class ScaffoldSample extends StatefulWidget {
  @override
  _ScaffoldSampleState createState() => _ScaffoldSampleState();
}

class _ScaffoldSampleState extends State<ScaffoldSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold Sample'),
      ),
      body: Center(
        child: TextField(),
      ),
      resizeToAvoidBottomInset: false, // 키보드가 올라옴에 따라 뒷배경이 올라오지 않도록
      drawerEdgeDragWidth: 20.0,
      drawerEnableOpenDragGesture: false,
      drawerScrimColor: Colors.red.withOpacity(0.2),
      drawer: Drawer(
        child: Center(
          child: Text('Slide Menu'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          print(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Colors.green,
        onPressed: () {},
      ),
    );
  }
}

