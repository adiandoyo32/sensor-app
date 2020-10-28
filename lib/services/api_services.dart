import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sensor_app/services/failure.dart';

class ApiService {
  final String url;

  ApiService(this.url);

  Future<dynamic> getData() async {
    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('No Internet Connection');
    } on HttpException {
      throw Failure("Couldn't find the sender 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  // Future<dynamic> postData(data) async {
  //   try {
  //     final http.Response response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data),
  //     );
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
