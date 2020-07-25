import 'dart:convert';
import 'dart:io';

import 'package:calenderly/global/api.dart';
import 'package:calenderly/global/keys.dart';
import 'package:calenderly/models/client_schedule_model.dart';
import 'package:calenderly/models/provider.dart';
import 'package:calenderly/models/provider_schedule_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiInterface with ChangeNotifier {
  // Variables
  String _token;
  String _userId;
  FlutterSecureStorage _secureStorage;

  ApiInterface() {
    init();
  }

  init() {
    _secureStorage = FlutterSecureStorage();
  }

  Future<void> getUserIdFromStorage() async {
    _userId = await _secureStorage.read(key: Keys.userId);
  }

  Future<void> getTokenFromStorage() async {
    _token = await _secureStorage.read(key: Keys.token);
  }

  Future<List<ClientScheduleModel>> viewMySchedules() async {
    await getUserIdFromStorage();
    await getTokenFromStorage();
    // print(_userId);
    // print(_token);
    HttpClient client = HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request =
        await client.postUrl(Uri.parse(API.viewSchedulesUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(Keys.token, _token);
    // print(request.headers);

    String body = '{"user_id" : "$_userId"}';
    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();

    List<ClientScheduleModel> result = [];
    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    var data = json.decode(temp);
    for (final node in data['data']) {
      result.add(ClientScheduleModel.fromJson(node));
    }
    // print(result);
    return result;
  }

  Future<List<ProviderModel>> fetchAllProviders() async {
    await getTokenFromStorage();
    HttpClient client = HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request =
        await client.postUrl(Uri.parse(API.fetchAllProviders));
    request.headers.set('content-type', 'application/json');
    request.headers.set(Keys.token, _token);

    HttpClientResponse response = await request.close();

    List<ProviderModel> result = [];
    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    var data = json.decode(temp);
    for (final node in data['data']) {
      result.add(ProviderModel.fromJson(node));
    }
    // print(result);
    return result;
  }

  Future<List<ProviderScheduleModel>> fetchLiveSchedules() async {
    await getTokenFromStorage();
    await getUserIdFromStorage();
    HttpClient client = HttpClient();

    DateTime date = DateTime.now();
    String formattedDate = '${date.year}-${date.month}-${date.day}';

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request =
        await client.postUrl(Uri.parse(API.fetchLiveSchedules));
    request.headers.set('content-type', 'application/json');
    request.headers.set(Keys.token, _token);

    String body = '{"user_id" : "$_userId", "date" : "$formattedDate"}';

    print(body);

    request.add(utf8.encode(body));
    HttpClientResponse response = await request.close();

    List<ProviderScheduleModel> result = [];
    Stream<String> val = response.transform(utf8.decoder);
    String temp = await val.join('');
    var data = json.decode(temp);
    for (final node in data['data']) {
      result.add(ProviderScheduleModel.fromJson(node));
    }
    // print(result);
    return result;
  }
}
