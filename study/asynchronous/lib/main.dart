import 'dart:isolate';

import 'package:flutter/material.dart';

void main() async {
  final receivePort = new ReceivePort();

  try {
    // Isolate
    await Isolate.spawn(echo, receivePort.sendPort);

    var sendPort = await receivePort.first;

    var msg = await sendReceive(sendPort, 'foo');
    msg = await sendReceive(sendPort, 'bar');

    print('msg : $msg');
  } catch (err) { print(err); }

  runApp(MyApp());
}

echo(SendPort sendPort) async {
  var port = new ReceivePort();
  sendPort.send(port.sendPort);

  await for (var msg in port) {
    var data = msg[0];
    SendPort replyTo = msg[1];
    replyTo.send(data);
    if (data == 'bar') port.close();
  }
}

Future sendReceive(SendPort port, msg) {
  ReceivePort response = new ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
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
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}
