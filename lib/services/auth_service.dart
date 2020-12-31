import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String _URL = "http://api.sensorku.tafexclusive.site";

class AuthService {
  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString('token');
    return token;
  }

  Future authData(String username, String password) async {
    var uri = _URL + '/api/get-client';
    var grantResponse = await http.get(uri);
    var grant = jsonDecode(grantResponse.body);
    String secret = grant['data']['secret'];

    Map<String, dynamic> body = {
      "grant_type": "password",
      "client_id": "2",
      "client_secret": secret,
      "username": username,
      "password": password
    };

    var loginResponse = await http.post(
      _URL + '/oauth/token',
      body: jsonEncode(body),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return jsonDecode(loginResponse.body);
  }

  Future getUserData(String email) async {
    var uri = _URL + '/api/findByEmail/$email';
    String token = await getToken();
    var responseJson = await http.get(
      uri,
      headers: setHeaders(token),
    );
    var response = jsonDecode(responseJson.body);
    return response;
  }

  setHeaders(String token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
