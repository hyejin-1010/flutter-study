import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_ion/flutter_ion.dart' as ion;
import 'package:uuid/uuid.dart';
import 'dart:developer';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pion/ion One to Many Broadcast'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Participant {
  Participant(this.title, this.renderer, this.stream);

  MediaStream? stream;
  String title;
  RTCVideoRenderer renderer;
}

class _MyHomePageState extends State<MyHomePage> {
  List<Participant> plist = <Participant>[];
  bool isPub = false;

  RTCVideoRenderer _localRender = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    initRender();
    initSfu();
  }

  void initRender() async {
    await _localRender.initialize();
    await _remoteRenderer.initialize();
  }

  ion.GRPCWebSignal getUrl() {
    if (kIsWeb) {
      // return ion.GRPCWebSignal('http://localhost:9090');
    } else {
      setState(() { isPub = true; });
      // return ion.GRPCWebSignal('http://192.168.219.152:9090');
    }
    return ion.GRPCWebSignal('http://192.168.219.152:9090');
  }

  ion.Signal? _signal;
  ion.Client? _client;
  ion.LocalStream? _localStream;
  final String _uuid = Uuid().v4();

  void initSfu() async {
    // TODO: await 이 필수인가? 필요없는 거 같은데 체크 필요한 듯!
    // final _signal = await getUrl();
    final _signal = getUrl();
    print('chloe test signal : $_signal');
    /// sid: root_name
    print('chloe test uuid : $_uuid');
    _client = await ion.Client.create(sid: 'test room', uid: _uuid, signal: _signal);
    print('chloe test 1');
    if (!isPub) {
      print('chloe test 2');
      _client?.ontrack = (track, ion.RemoteStream remoteStream) async {
        print('chloe test 3');
        if (track.kind == 'video') {
          print('chloe test 4');
          print('on track: remote stream => ${remoteStream.id}');
          setState(() {
            _remoteRenderer.srcObject = remoteStream.stream;
          });
        }
      };
    }
  }

  // publish function
  void publish() async {
    _localStream = await ion.LocalStream.getUserMedia(constraints: ion.Constraints.defaults..simulcast = false);
    setState(() {
      _localRender.srcObject = _localStream?.stream;
    });

    await _client?.publish(_localStream!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getVideoView(),
          ],
        ),
      ),
      floatingActionButton: _buildFabButton(),
    );
  }

  // video view
  Widget _getVideoView() {
    if (isPub) {
      return Expanded(
        child: RTCVideoView(_localRender),
      );
    }
    return Expanded(
      child: RTCVideoView(_remoteRenderer),
    );
  }

  // publish button
  Widget _buildFabButton() {
    if (!isPub) { return Container(); }
    return FloatingActionButton(
      onPressed: publish,
      tooltip: 'publish',
      child: Icon(Icons.video_call),
    );
  }
}

