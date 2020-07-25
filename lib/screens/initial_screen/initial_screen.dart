import 'package:calenderly/providers/app_state.dart';
import 'package:calenderly/routes/routes.dart';
import 'package:calenderly/screens/client_screens/client_dashboard.dart';
import 'package:calenderly/screens/provider_screens/provider_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context);
    // print('run');
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: _getBody(provider, context),
    );
  }

  _getBody(AppState provider, BuildContext context) {
    LoginState loginState = provider.loginState;
    Widget _child;
    switch (loginState) {
      case LoginState.NotLoggedIn:
        _child = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('I want to provide services'),
                onPressed: () =>
                    Navigator.pushNamed(context, Router.providerLogin),
              ),
              RaisedButton(
                child: Text('I want to avail services'),
                onPressed: () {
                  Navigator.pushNamed(context, Router.clientLogin);
                },
              ),
            ],
          ),
        );
        break;
      case LoginState.LoggingIn:
        _child = Center(child: CircularProgressIndicator());
        break;
      case LoginState.LoggedInAsClient:
        _child = ClientDashboard();
        break;
      case LoginState.LoggedInAsProvider:
        _child = ProviderDashboard();
        break;
      default:
        _child = Text('Default');
        break;
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: _child,
    );
  }
}
