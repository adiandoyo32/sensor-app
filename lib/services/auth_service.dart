import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String _URL = "http://api.sensorku.tafexclusive.site";

class AuthService {
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }

  authData(String username, String password) async {
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
    // return await http.post(uri,
    //     body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _URL + apiUrl;
    await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
