import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

const HOST = 'mqtt://a3g9lwq85r20wi-ats.iot.ap-northeast-2.amazonaws.com';
const CLIENT_ID = 'AppTest';
const PREFIX = '\$aws/things/Test/shadow';

class AWSTestScreen extends StatefulWidget {
  const AWSTestScreen({Key? key}) : super(key: key);

  @override
  _AWSTestScreenState createState() => _AWSTestScreenState();
}

class _AWSTestScreenState extends State<AWSTestScreen> {
  MqttServerClient client = MqttServerClient(HOST, '');
  String status = '';
  bool connected = false;
  bool toggleValue = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Spacer(),
          Switch(value: toggleValue, onChanged: (_) {}),
          connected
              ? ElevatedButton(onPressed: _disconnect, child: Text('DisConnect'))
              : ElevatedButton(onPressed: _connect, child: Text('Connect')),
          if (connected)
            ElevatedButton(onPressed: _publish, child: Text('Publish')),
          Spacer(),
        ],
      ),
    );
  }

  _connect() async {
    try {
      bool result = await mqttConnect('');
      if (result == false) { return; }
      setState(() {
        connected = true;
      });
    } catch (_) {}
  }

  _disconnect() {
    client.disconnect();
  }

  _publish () {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    client.publishMessage('$PREFIX/get', MqttQos.atLeastOnce, builder.payload!);
  }

  Future<bool> mqttConnect(String uniqueId) async {
    setStatus('Connecting MQTT Broker');
    ByteData rootCA = await rootBundle.load('assets/certs/root-CA.crt');
    ByteData deviceCert = await rootBundle.load('assets/certs/Test.cert.pem');
    ByteData privateKey = await rootBundle.load('assets/certs/Test.private.key');

    SecurityContext context = SecurityContext.defaultContext;
    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

    client = MqttServerClient('a3g9lwq85r20wi-ats.iot.ap-northeast-2.amazonaws.com', CLIENT_ID);
    client.securityContext = context;
    client.logging(on: true);
    client.keepAlivePeriod = 300;
    client.port = 8883;
    client.secure = true;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(CLIENT_ID)
        .startClean();
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (err) { print('${err.toString()}'); }

    if (client.connectionStatus!.state != MqttConnectionState.connected) { return false; }

    String acceptedTopic = '$PREFIX/get/accepted';
    String rejectedTopic = '$PREFIX/get/rejected';
    client.subscribe(acceptedTopic, MqttQos.atMostOnce);
    client.subscribe(rejectedTopic, MqttQos.atMostOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      String topic = c[0].topic;
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      if (message.payload.message == null) { return; }
      // String data = utf8.decode(message.payload.message!);
      // dynamic response = json.decode(data);
      // print('chloe test listen topic: $topic, response: $response');
      if (topic == acceptedTopic) {
        setState(() { toggleValue = !toggleValue; });
      }
    });

    return false;
  }

  void onConnected() {
    setStatus('Chloe Client connection was successful');
    setState(() { connected = true; });
  }

  void onDisconnected() {
    setStatus('Chloe Client Disconnected');
    setState(() { connected = false; });
  }

  void pong() {
    setStatus('Chloe Ping response client callback invoked');
  }

  void onSubscribed(String topic) {
    print('Chloe Client onSubscribed $topic');
  }

  void onSubscribeFail(String topic) {
    print('Chloe Client onSubscribeFail $topic');
  }

  void setStatus(String content) {
    setState(() { status = content; });
  }
}
