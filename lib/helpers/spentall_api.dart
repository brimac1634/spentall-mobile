import 'dart:io';

import 'package:http/http.dart' as http;

import 'custom_exceptions.dart';

class SpentAllApi {
  static const url = 'https://spentall-server.herokuapp.com';

  Future<dynamic> get(
      {String endPoint, Map<String, String> headers, String token}) async {
    try {
      final response = await http.get(
        '$url$endPoint',
        headers: headers != null
            ? headers
            : {
                'x-access-token': 'Bearer $token',
              },
      );
      return _returnResponse(response);
    } on SocketException {
      throw CustomException('Unable to connect');
    }
  }

  Future<dynamic> post(
      {String endPoint,
      Map<String, String> headers,
      dynamic body,
      String token}) async {
    try {
      final response = await http.post('$url$endPoint',
          headers: headers != null
              ? headers
              : {
                  'Content-Type': 'application/json',
                  'x-access-token': 'Bearer $token',
                },
          body: body);
      return _returnResponse(response);
    } on SocketException {
      throw CustomException('Unable to connect');
    }
  }

  dynamic _returnResponse(http.Response response) {
    if (response.statusCode < 300) {
      return response;
    } else if (response.statusCode >= 300) {
      throw CustomException(response.body.toString());
    }
  }
}
