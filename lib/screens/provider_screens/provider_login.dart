import 'package:calenderly/models/user.dart';
import 'package:calenderly/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderLogin extends StatelessWidget {
  PageController _controller = PageController(initialPage: 0);
  TextEditingController _loginEmailController = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();
  TextEditingController _registerEmailController = TextEditingController();
  TextEditingController _registerPasswordController = TextEditingController();
  TextEditingController _registerPasswordConfirmController =
      TextEditingController();
  TextEditingController _registerNameController = TextEditingController();
  TextEditingController _registerPhoneController = TextEditingController();
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
                        .loginAsProvider(_loginEmailController.text,
                            _loginPasswordController.text)
                        .then((value) {
                      // print('popping');
                      Navigator.pop(context);
                    });
                  },
                ),
                RaisedButton(
                  child: Text('Not a user ? / Create an account'),
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
                TextFormField(
                  controller: _registerEmailController,
                  decoration: InputDecoration(
                    hintText: 'email',
                  ),
                ),
                TextFormField(
                  controller: _registerPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'password'),
                ),
                TextFormField(
                  controller: _registerPasswordConfirmController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'confirm password'),
                ),
                TextFormField(
                  controller: _registerNameController,
                  decoration: InputDecoration(hintText: 'name'),
                ),
                TextFormField(
                  controller: _registerPhoneController,
                  decoration: InputDecoration(hintText: 'phone'),
                ),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () {
                    User user = User(
                      name: _registerNameController.text,
                      email: _registerEmailController.text,
                      password: _registerPasswordController.text,
                      phone: _registerPhoneController.text,
                      type: '0',
                    );
                    provider.registerAsProvider(user).then((value) {
                      if (value) {
                        Navigator.pop(context);
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Registration failed')));
                      }
                    });
                  },
                ),
                RaisedButton(
                  child: Text('An exisiting user?/Login'),
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
