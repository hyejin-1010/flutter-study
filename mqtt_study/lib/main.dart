import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MqttServerClient? client;
  TextEditingController controller = TextEditingController();
  List<String> messages = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('MQTT'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              client != null
                  ? ElevatedButton(onPressed: disconnect, child: Text('DisConnect'))
                  : ElevatedButton(onPressed: connect, child: Text('Connect')),
              ListView.builder(
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Text(messages[index]),
                  );
                },
              ),
              Spacer(),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: '여기에 입략해주세요.',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      publish();
                    },
                    child: Text('Publish'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<MqttServerClient> connect() async {
    setState(() {
      client = MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);
    });
    client!.logging(on: true);
    client!.onConnected = onConnected;
    client!.onDisconnected = onDisconnected;
    client!.onUnsubscribed = onUnsubscribed;
    client!.onSubscribed = onSubscribed;
    client!.onSubscribeFail = onSubscribeFail;
    client!.pongCallback = pong;

    final connMessage = MqttConnectMessage()
      .withWillTopic('hello')
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMessage;

    try {
      await client!.connect();
    } catch (e) {
      client!.disconnect();
    }
    client!.subscribe('hello', MqttQos.atLeastOnce);
    client!.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      if (message.payload.message == null) { return; }
      final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message!);
      setState(() {
        messages.add(payload);
      });
    });

    return client!;
  }

  void disconnect () {
    if (client == null) { return; }
    client!.disconnect();
    setState(() {
      client = null;
    });
  }

  void publish () {
    if (controller.text.isEmpty) { return; }
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(controller.text);
    client?.publishMessage('hello', MqttQos.atLeastOnce, builder.payload!);
    setState(() { controller.text = ''; });
  }

  void onConnected() {
    print('chloe test Connected');
  }

  void onDisconnected() {
    print('chloe test  Disconnected');
    setState(() {
      client = null;
    });
  }

  void onSubscribed(String topic) {
    print('chloe test Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('chloe test Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('chloe test Unsubscribed topic: $topic');
  }

  void pong() {
    print('Ping response client callback invoked');
  }
}