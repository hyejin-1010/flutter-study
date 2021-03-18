import 'package:flutter/material.dart';
import 'package:nested_navigation_flow/setup-flow.dart';

void main() {
  runApp(MyApp());
}

const routeHome = '/';
const routeSettings = '/settings';
const routePrefixDeviceSetup = '/setup/';
const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Navigator(
          onGenerateRoute: (settings) {
            late Widget page;

            if (settings.name == routeHome) {
              page = HomeScreen();
            } else if (settings.name == routeSettings) {
              page = SettingsScreen();
            } else if (settings.name!.startsWith(routePrefixDeviceSetup)) {
              final subRoute = settings.name!.substring(
                routePrefixDeviceSetup.length,
              );
              page = SetupFlow(
                initialSetupRoute: subRoute,
              );
            } else {
              throw Exception('Unknown route: ${settings.name}');
            }

            return MaterialPageRoute<dynamic>(
              builder: (context) {
                return page;
              },
              settings: settings,
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('SettingsScreen'),
      ),
    );
  }
}


