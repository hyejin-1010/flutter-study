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

const String serverAPI = 'broker.emqx.io';
const String identifier = 'flutter_client';
const int port = 1883;
const String topic = 'hello';

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
          child: client != null
            ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  ElevatedButton(onPressed: disconnect, child: Text('DisConnect')),
                  _buildMessageListView(),
                  Spacer(),
                  _buildInputBox(),
                ],
              ),
            )
          : ConnectPage(
            onConnect: connect,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageListView () {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Text(messages[index]),
        );
      },
    );
  }

  Widget _buildInputBox () {
    return Row(
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
          onPressed: publish,
          child: Text('Publish'),
        ),
      ],
    );
  }

  Future<MqttServerClient> connect() async {
    setState(() {
      client = MqttServerClient.withPort(serverAPI, identifier, port);
    });
    client!.logging(on: true);
    client!.onConnected = onConnected;
    client!.onDisconnected = onDisconnected;
    client!.onUnsubscribed = onUnsubscribed;
    client!.onSubscribed = onSubscribed;
    client!.onSubscribeFail = onSubscribeFail;
    client!.pongCallback = pong;

    final connMessage = MqttConnectMessage()
      .withWillTopic(topic)
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMessage;

    try {
      await client!.connect();
    } catch (e) {
      client!.disconnect();
    }
    client!.subscribe(topic, MqttQos.atLeastOnce);
    client!.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      if (message.payload.message == null) { return; }
      final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message!);
      // Uint8List bytes = Uint8List.fromList(message.payload.message!.toList());
      // ByteData byteData = message.payload.message!.buffer.asByteData();
      // ByteBuffer buffer = byteData.buffer;
      // Uint8List list = buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      // print('chloe test ?--- ' + utf8.decode(list));
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
      messages = [];
    });
  }

  void publish () {
    if (controller.text.isEmpty) { return; }
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(controller.text);
    client?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    setState(() { controller.text = ''; });
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
    setState(() {
      client = null;
      messages = [];
    });
  }

  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  void pong() {
    print('Ping response client callback invoked');
  }
}

class ConnectPage extends StatefulWidget {
  final Future<MqttServerClient> Function() onConnect;
  const ConnectPage({
    Key? key,
    required this.onConnect,
  }) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final TextEditingController _serverCtrl = TextEditingController();
  final TextEditingController _identifierCtrl = TextEditingController();
  final TextEditingController _portCtrl = TextEditingController();
  final TextEditingController _topicCtrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _serverCtrl.text = serverAPI;
    _identifierCtrl.text = identifier;
    _portCtrl.text = port.toString();
    _topicCtrl.text = topic;
  }

  @override
  void dispose() {
    _serverCtrl.dispose();
    _identifierCtrl.dispose();
    _portCtrl.dispose();
    _topicCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTextInputBox('Server', _serverCtrl),
        _buildTextInputBox('identifier', _identifierCtrl),
        _buildTextInputBox('port', _portCtrl),
        _buildTextInputBox('topic', _topicCtrl),
        ElevatedButton(onPressed: widget.onConnect, child: Text('Connect'))
      ],
    );
  }

  Widget _buildTextInputBox (String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: TextField(
              controller: ctrl,
            ),
          ),
        ],
      ),
    );
  }
}
