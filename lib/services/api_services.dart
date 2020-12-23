import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sensor_app/services/failure.dart';

class ApiService {
  final String url;

  ApiService(this.url);

  Future<dynamic> getData() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiODhhYTQ5ZjRmN2EwODRmMzJiZTM3NDYxNzBiOTIyNWI1MTNlMTI4ZGI1MTZkODYxNzM1MjNjNGJiZDhhOWNiZWVkODJiMWNiMWQ0YzczYjAiLCJpYXQiOjE2MDc0OTkyNjcsIm5iZiI6MTYwNzQ5OTI2NywiZXhwIjoxNjM5MDM1MjY3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.FI6g2xCRmWNZQPL2iYaxs6OzOLx5hKHXNOqhzl3C7KpCkkKYHEpmpHJPfHuwX4mGjjrUf4mv27unE3-d27kWmBLcLu0450fAIz5eQVhcbjRckcF20OupZUKxNMPjJvEURrMZ7FSg8dlccovjOP20ewAD6QGMGJzUQRLo9rs-13qv57QWCYJVYycISyveb_u31dFFBPvWEdtsWs4iqnb92HMP9rA-b5TZ4A2kdx9qFdNXDNas4u7L6xyZOa0kO1t9HrpbGinT7SIhIWMtI8jn91_ESeWXyjwBamGvOKi9n5gK9cBcRH26SeKe3BGJ4tuy1sE06DtmLli9wRpI1MI5Up5ujywFEJCQBB5zArW2JTvuaiwFfkr9qZvZiQIweguIwic3amc4UYzR_sVlSvDMMb3-SK6S-ylgjluHK9VG3SUvfLizc83g102V9UJlNth2-SNDN_awEUUd_gAwef5rV9MHUEXsMtNOL3_upEAG-oJy0V_96E89zRrmlLwDU-34BTvYZ_DGVj1g1hoQ46PR0kg_oZgxPveJTIrFa8LwkYdI8Ys2DnQwgLBCXDVQ8kXsjQVs7xBOEFjJ4Sewq2Z2cUeAkFDSK20WZD07VpeOVHK0ioTynqnE4RnyVaZde2YtmEFB1a9RsZD--dz117woVU3m6GP95N1v-IzrPRWRAGs",
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
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiODhhYTQ5ZjRmN2EwODRmMzJiZTM3NDYxNzBiOTIyNWI1MTNlMTI4ZGI1MTZkODYxNzM1MjNjNGJiZDhhOWNiZWVkODJiMWNiMWQ0YzczYjAiLCJpYXQiOjE2MDc0OTkyNjcsIm5iZiI6MTYwNzQ5OTI2NywiZXhwIjoxNjM5MDM1MjY3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.FI6g2xCRmWNZQPL2iYaxs6OzOLx5hKHXNOqhzl3C7KpCkkKYHEpmpHJPfHuwX4mGjjrUf4mv27unE3-d27kWmBLcLu0450fAIz5eQVhcbjRckcF20OupZUKxNMPjJvEURrMZ7FSg8dlccovjOP20ewAD6QGMGJzUQRLo9rs-13qv57QWCYJVYycISyveb_u31dFFBPvWEdtsWs4iqnb92HMP9rA-b5TZ4A2kdx9qFdNXDNas4u7L6xyZOa0kO1t9HrpbGinT7SIhIWMtI8jn91_ESeWXyjwBamGvOKi9n5gK9cBcRH26SeKe3BGJ4tuy1sE06DtmLli9wRpI1MI5Up5ujywFEJCQBB5zArW2JTvuaiwFfkr9qZvZiQIweguIwic3amc4UYzR_sVlSvDMMb3-SK6S-ylgjluHK9VG3SUvfLizc83g102V9UJlNth2-SNDN_awEUUd_gAwef5rV9MHUEXsMtNOL3_upEAG-oJy0V_96E89zRrmlLwDU-34BTvYZ_DGVj1g1hoQ46PR0kg_oZgxPveJTIrFa8LwkYdI8Ys2DnQwgLBCXDVQ8kXsjQVs7xBOEFjJ4Sewq2Z2cUeAkFDSK20WZD07VpeOVHK0ioTynqnE4RnyVaZde2YtmEFB1a9RsZD--dz117woVU3m6GP95N1v-IzrPRWRAGs",
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
