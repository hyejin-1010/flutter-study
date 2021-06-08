import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(MyApp());
}

const TEMP = {
  'server': 'broker.emqx.io',
  'identifier': 'flutter_client',
  'port': '1883',
  'topic': 'hello'
};
const KEYS = ['server', 'identifier', 'port', 'topic'];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MqttServerClient? client;
  TextEditingController controller = TextEditingController();
  List<String> messages = [];
  String currentTopic = '';

  Map<String, String>? info;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setInfo();
  }

  Future<void> _setInfo () async {
    Map<String, String> temp = {};
    final _storage = FlutterSecureStorage();
    for (var key in ['server', 'identifier', 'port', 'topic']) {
      String? value = await _storage.read(key: key);
      temp[key] = value ?? TEMP[key] ?? '';
    }
    setState(() { info = temp; });
  }

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
          : info == null
              ? Center(child: CircularProgressIndicator())
              : ConnectPage(
                info: info!,
                onConnect: onConnect,
              ),
        ),
      ),
    );
  }

  Widget _buildMessageListView () {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: messages.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
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
              hintText: '여기에 입력해주세요.',
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

  void setLocalStorage (Map<String, String> data) {
    final _storage = FlutterSecureStorage();
    for (String key in KEYS) {
      _storage.write(key: key, value: data[key]);
    }
    info = data;
  }

  Future<MqttServerClient> onConnect(Map<String, String> data) async {
    setState(() {
      client = MqttServerClient.withPort(data['server']!, data['identifier']!, int.parse(data['port']!));
    });
    setLocalStorage(data);
    client!.logging(on: true);
    client!.onConnected = onConnected;
    client!.onDisconnected = onDisconnected;
    client!.onUnsubscribed = onUnsubscribed;
    client!.onSubscribed = onSubscribed;
    client!.onSubscribeFail = onSubscribeFail;
    client!.pongCallback = pong;
    currentTopic = data['topic'] ?? '';

    final connMessage = MqttConnectMessage()
      .withWillTopic(currentTopic)
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMessage;

    try {
      await client!.connect();
    } catch (e) { client!.disconnect(); }
    _onSubscribe(currentTopic);
    return client!;
  }

  void _onSubscribe (String topic) {
    client!.subscribe(topic, MqttQos.atLeastOnce);
    client!.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      if (message.payload.message == null) { return; }
      String data = utf8.decode(message.payload.message!);
      dynamic response = json.decode(data);
      setState(() { messages.add(response['text']); });
    });
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

    dynamic data = { 'text': controller.text };
    builder.addUTF8String(json.encode(data));
    client?.publishMessage(currentTopic, MqttQos.atLeastOnce, builder.payload!);
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
  final Future<MqttServerClient> Function(Map<String, String>) onConnect;
  final Map<String, String> info;

  const ConnectPage({
    Key? key,
    required this.info,
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
    _serverCtrl.text = widget.info['server'] ?? '';
    _identifierCtrl.text = widget.info['identifier'] ?? '';
    _portCtrl.text = widget.info['port'] ?? '';
    _topicCtrl.text = widget.info['topic'] ?? '';
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
        ElevatedButton(
          onPressed: () {
            widget.info['server'] = _serverCtrl.text;
            widget.info['identifier'] = _identifierCtrl.text;
            widget.info['port'] = _portCtrl.text;
            widget.info['topic'] = _topicCtrl.text;
            widget.onConnect(widget.info);
          },
          child: Text('Connect'),
        ),
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
