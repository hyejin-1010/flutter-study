import 'package:flutter/material.dart';
import 'package:nested_navigation_flow/main.dart';

class SetupFlow extends StatefulWidget {
  static _SetupFlowState of(BuildContext context) {
    return context.findAncestorStateOfType<_SetupFlowState>()!;
  }

  const SetupFlow({
    Key? key,
    required this.initialSetupRoute
  }) : super(key: key);

  final String initialSetupRoute;

  @override
  _SetupFlowState createState() => _SetupFlowState();
}

class _SetupFlowState extends State<SetupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  void _onDiscoveryComplete() {
    _navigatorKey.currentState!.pushNamed(
      routeDeviceSetupSelectDevicePage,
    );
  }

  void _onDeviceSelected(String deviceId) {
    _navigatorKey.currentState!.pushNamed(
      routeDeviceSetupConnectingPage,
    );
  }

  void _onConnectionEstablished() {
    _navigatorKey.currentState!.pushNamed(
      routeDeviceSetupFinishedPage
    );
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('If you exit device setup, your progress will be lost'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Leave'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Stay'),
              ),
            ],
          );
        }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Scaffold(
        appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.initialSetupRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    print("-name-");
    print(settings.name);
    switch (settings.name) {
      case routeDeviceSetupStartPage:
        page = WaitingPage(
          message: 'Searching for nearby bulb',
          onWaitComplete: _onDiscoveryComplete
        );
        break;
      case routeDeviceSetupSelectDevicePage:
        page = SelectDevicePage(
          onDeviceSelected: _onDeviceSelected,
        );
        break;
      case routeDeviceSetupConnectingPage:
        page = WaitingPage(
          message: 'Connecting ...',
          onWaitComplete: _onConnectionEstablished,
        );
        break;
      case routeDeviceSetupFinishedPage:
        page = FinishPage(
          onFinishPressed: _exitSetup,
        );
        break;
    }

    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: Icon(Icons.chevron_left),
      ),
      title: Text('Bulb Setup'),
    );
  }
}

class WaitingPage extends StatefulWidget {
  const WaitingPage({
    Key? key,
    required this.message,
    required this.onWaitComplete
  }) : super(key: key);

  final String message;
  final VoidCallback onWaitComplete;
  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _startWaiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3));

    if (mounted) {
      widget.onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 32),
              Text(widget.message)
            ],
          ),
        ),
      ),
    );
  }
}


class SelectDevicePage extends StatelessWidget {
  const SelectDevicePage({
    Key? key,
    required this.onDeviceSelected
  }) : super(key: key);
  final void Function(String deviceId) onDeviceSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select a nearby device',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return const Color(0xFF222222);
                    })
                  ),
                  onPressed: () {
                    onDeviceSelected('22n483nk5834');
                  },
                  child: Text(
                    'Bulb 22n483nk5834',
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FinishPage extends StatelessWidget {
  const FinishPage({
    Key? key,
    required this.onFinishPressed
  }) : super(key: key);
  final VoidCallback onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Bulb added!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) {
                    return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    return const Color(0xFF222222);
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return StadiumBorder();
                  }),
                ),
                onPressed: onFinishPressed,
                child: Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 24
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


