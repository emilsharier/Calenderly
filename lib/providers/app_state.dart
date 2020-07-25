import 'dart:convert';
import 'dart:io';

import 'package:calenderly/global/api.dart';
import 'package:calenderly/global/keys.dart';
import 'package:calenderly/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState { NotLoggedIn, LoggingIn, LoggedInAsClient, LoggedInAsProvider }

class AppState with ChangeNotifier {
  // Variables
  String _userId = '0';
  String _token = '';
  LoginState _loginState = LoginState.NotLoggedIn;
  SharedPreferences _pref;
  FlutterSecureStorage _secureStorage;

  // Getters
  LoginState get loginState => _loginState;

  // init
  AppState() {
    init();
  }

  init() async {
    _pref = await SharedPreferences.getInstance();
    _secureStorage = FlutterSecureStorage();
    loadLoginState();
  }

  loadLoginState() async {
    bool value = _pref.containsKey(Keys.loginState);
    if (value) {
      _loginState = getLoginStateFromPref();
      // print(_loginState);
    } else {
      setLoginStateToPref(LoginState.NotLoggedIn);
    }
    notifyListeners();
  }

  // Methods
  setLoginStateToPref(LoginState state) {
    _pref.setString(Keys.loginState, state.toString());
  }

  setLoginState(LoginState state) {
    _loginState = state;
    notifyListeners();
  }

  LoginState getLoginStateFromPref() {
    String value = _pref.getString(Keys.loginState);
    switch (value) {
      case 'LoginState.NotLoggedIn':
        return LoginState.NotLoggedIn;
        break;
      case 'LoginState.LoggingIn':
        return LoginState.LoggingIn;
        break;
      case 'LoginState.LoggedInAsClient':
        getUserIdFromStorage();
        return LoginState.LoggedInAsClient;
        break;
      case 'LoginState.LoggedInAsProvider':
        getUserIdFromStorage();
        return LoginState.LoggedInAsProvider;
        break;
      default:
        return LoginState.NotLoggedIn;
        break;
    }
  }

  Future<void> getUserIdFromStorage() async {
    _userId = await _secureStorage.read(key: Keys.userId);
  }

  Future<void> getTokenFromStorage() async {
    _token = await _secureStorage.read(key: Keys.token);
  }

  Future<void> setUserIdToStorage(String id) async {
    print(id);
    await _secureStorage.write(key: Keys.userId, value: id);
  }

  Future<void> setToken(String token) async {
    await _secureStorage.write(key: Keys.token, value: token);
  }

  Future loginAsClient(String email, String password) async {
    setLoginState(LoginState.LoggingIn);
    HttpClient client = HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String body = '{"email" : "$email", "password" : "$password"}';
    HttpClientRequest request = await client.postUrl(Uri.parse(API.signin_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();

    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    Map<String, dynamic> result = json.decode(temp);
    if (response.statusCode == 403) {
      setLoginState(LoginState.NotLoggedIn);
    } else {
      await setToken(result['accessToken']);
      await setUserIdToStorage(result['id'].toString());
      setLoginState(LoginState.LoggedInAsClient);
      setLoginStateToPref(LoginState.LoggedInAsClient);
    }
  }

  Future loginAsProvider(String email, String password) async {
    setLoginState(LoginState.LoggingIn);
    HttpClient client = HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String body = '{"email" : "$email", "password" : "$password"}';
    HttpClientRequest request = await client.postUrl(Uri.parse(API.signin_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();

    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    // print(temp);
    Map<String, dynamic> result = json.decode(temp);
    if (response.statusCode == 403) {
      setLoginState(LoginState.NotLoggedIn);
    } else {
      await setToken(result['accessToken']);
      await setUserIdToStorage(result['id'].toString());
      setLoginState(LoginState.LoggedInAsProvider);
      setLoginStateToPref(LoginState.LoggedInAsProvider);
    }
  }

  Future<bool> registerAsClient(User user) async {
    HttpClient client = HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String body =
        '{"email" : "${user.email}", "password" : "${user.password}", "name" : "${user.name}", "type" : "0", "phone" : "${user.phone}"}';
    HttpClientRequest request = await client.postUrl(Uri.parse(API.signin_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();

    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    Map<String, dynamic> result = json.decode(temp);
    if (response.statusCode == 403) {
      // Not registered
      print('Registration unsuccessfull');
    } else {
      await setToken(result['accessToken']);
      await setUserIdToStorage(result['id']);
      await getUserIdFromStorage();
    }
  }

  Future registerAsProvider(User user) async {
    HttpClient client = HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String body =
        '{"email" : "${user.email}", "password" : "${user.password}", "name" : "${user.name}", "type" : "0", "phone" : "${user.phone}"}';
    HttpClientRequest request = await client.postUrl(Uri.parse(API.signin_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();

    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    Map<String, dynamic> result = json.decode(temp);
    if (response.statusCode == 403) {
      // Not registered
      print('Registration unsuccessfull');
    } else {
      await setToken(result['accessToken']);
      await setUserIdToStorage(result['id']);
      await getUserIdFromStorage();
    }
  }
}
