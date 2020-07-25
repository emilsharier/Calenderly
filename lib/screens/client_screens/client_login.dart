import 'package:calenderly/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientLogin extends StatelessWidget {
  PageController _controller = PageController(initialPage: 0);
  TextEditingController _loginEmailController = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _loginEmailController,
                ),
                TextFormField(
                  controller: _loginPasswordController,
                ),
                RaisedButton(
                    child: Text('Login'),
                    onPressed: () {
                      provider
                          .loginAsClient(_loginEmailController.text,
                              _loginPasswordController.text)
                          .then((value) => Navigator.pop(context));
                    }),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () => _controller.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(),
                TextFormField(),
                TextFormField(),
                TextFormField(),
                TextFormField(),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () => _controller.animateToPage(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
