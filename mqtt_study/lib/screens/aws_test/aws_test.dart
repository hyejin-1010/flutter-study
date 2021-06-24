import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class AWSTestScreen extends StatefulWidget {
  const AWSTestScreen({Key? key}) : super(key: key);

  @override
  _AWSTestScreenState createState() => _AWSTestScreenState();
}

class _AWSTestScreenState extends State<AWSTestScreen> {
  
  MqttServerClient client = MqttServerClient('mqtt://a3g9lwq85r20wi-ats.iot.ap-northeast-2.amazonaws.com', '');
  String status = '';
  bool connected = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: connected
          ? ElevatedButton(onPressed: _disconnect, child: Text('DisConnect'))
          : ElevatedButton(onPressed: _connect, child: Text('Connect')),
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

  Future<bool> mqttConnect(String uniqueId) async {
    setStatus('Connecting MQTT Broker');
    ByteData rootCA = await rootBundle.load('assets/certs/root-CA.crt');
    ByteData deviceCert = await rootBundle.load('assets/certs/Test.cert.pem');
    ByteData privateKey = await rootBundle.load('assets/certs/Test.private.key');

    SecurityContext context = SecurityContext.defaultContext;
    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

    // String id = 'sdk-nodejs-d0772ced-6431-419b-bf8b-1d35f33de11b';
    String id = 'AppTest';

    client = MqttServerClient('a3g9lwq85r20wi-ats.iot.ap-northeast-2.amazonaws.com', id);
    client.securityContext = context;
    // client.logging(on: true);
    // client.keepAlivePeriod = 300;
    client.port = 8883;
    client.secure = true;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(id)
        .startClean();
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (err) { print('${err.toString()}'); }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Chloe Connected to AWS Successfully!');
    } else { return false; }

    // String acceptedTopic = '\$aws/things/AppTest/shadow/get/accepted';
    client.subscribe('topic_2', MqttQos.atMostOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      if (message.payload.message == null) { return; }
      String data = utf8.decode(message.payload.message!);
      dynamic response = json.decode(data);
      print('chloe test accept : $response');
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
