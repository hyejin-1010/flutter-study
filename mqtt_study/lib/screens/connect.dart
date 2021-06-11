import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class ConnectScreen extends StatefulWidget {
  final Future<MqttServerClient> Function(Map<String, String>) onConnect;
  final Map<String, String> info;

  const ConnectScreen({
    Key? key,
    required this.info,
    required this.onConnect,
  }) : super(key: key);

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
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
