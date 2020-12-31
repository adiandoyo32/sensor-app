import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sensor_app/services/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String url;

  ApiService(this.url);

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString('token');
    return token;
  }

  Future<dynamic> getData() async {
    String token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      final http.Response response = await http.get(url, headers: headers);
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('No Internet Connection');
    } on HttpException {
      throw Failure("Couldn't find the sender 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  Future<dynamic> patchData(body) async {
    String token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final http.Response response =
          await http.patch(url, headers: headers, body: jsonEncode(body));
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('No Internet Connection');
    } on HttpException {
      throw Failure("Couldn't find the sender 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }
}
