import 'dart:convert';
import 'dart:io';

import 'package:calenderly/global/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState { NotLoggedIn, LogginIn, LoggedInAsClient, LoggedInAsProvider }

class AppState with ChangeNotifier {
  // Variables
  LoginState _loginStatus = LoginState.NotLoggedIn;
  SharedPreferences _pref;
  FlutterSecureStorage _secureStorage;

  // init
  AppState() {
    init();
  }

  init() async {
    _pref = await SharedPreferences.getInstance();
    _secureStorage = FlutterSecureStorage();
  }

  // Methods
  Future loginAsClient(String email, String password) async {
    HttpClient client = HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String body = '{"email" : "${email}", "password" : "${password}"}';
    HttpClientRequest request = await client.postUrl(Uri.parse(API.signin_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();

    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    print(temp);
  }

  Future loginAsProvider(String email, String password) async {}

  Future registerAsClient(String email, String password) async {}

  Future registerAsProvider(String email, String password) async {}
}
