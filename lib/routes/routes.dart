import 'package:calenderly/screens/client_screens/client_login.dart';
import 'package:calenderly/screens/initial_screen/initial_screen.dart';
import 'package:calenderly/screens/provider_screens/provider_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static const String initialScreen = '/intial_screen';
  static const String clientLogin = '/client_login';
  static const String providerLogin = '/provider_login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialScreen:
        return MaterialPageRoute(
          builder: (context) => InitialScreen(),
        );
        break;
      case clientLogin:
        return MaterialPageRoute(
          builder: (context) => ClientLogin(),
        );
        break;
      case providerLogin:
        return MaterialPageRoute(
          builder: (context) => ProviderLogin(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => InitialScreen(),
        );
        break;
    }
  }
}
