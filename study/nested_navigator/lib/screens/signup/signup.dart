import 'package:flutter/material.dart';
import 'package:nested_navigator/screens/signup/screens/choose_credentials.dart';
import 'package:nested_navigator/screens/signup/screens/collect_personal_info.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'signup/personal_info',
      onGenerateRoute: (RouteSettings settings) {
        late WidgetBuilder builder;
        switch (settings.name) {
          case 'signup/personal_info':
            builder = (BuildContext _) => CollectPersonalInfoPage();
            break;
          case 'signup/credentials':
            builder = (BuildContext _) => ChooseCredentialsPage(
              onSignupCompleted: () => Navigator.pop(context)
            );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings
        );
      },
    );
  }
}
