import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// A mix-and-match approach
class ParentWidget extends StatefulWidget {
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TabboxC extends StatefulWidget {
  TabboxC({Key key, this.active: false, @required this.onChanged})
    : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _TabboxCState createState() => _TabboxCState();
}

class _TabboxCState extends State<TabboxC> {
  bool _highlight = false;

  void _handleTabDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTabUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTabCancel () {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTab() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTabDown,
      onTapUp: _handleTabUp,
      onTap: _handleTab,
      onTapCancel: _handleTabCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'InActive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? Border.all(color: Colors.teal[700], width: 10.0) : null,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: ParentWidget(),
        ),
      )
    );
  }
}
