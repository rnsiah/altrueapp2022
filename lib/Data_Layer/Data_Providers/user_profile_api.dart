import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class ApiProvider {
  // ignore: unused_field

  final String _mobileBaseUrl =
      'http://dd05-2601-2c6-47e-4690-e9bb-3d97-d2ca-570a.ngrok.io';
  final String _baseUrl = "http://10.0.0.238:8000/";

  Future<dynamic> getUserAuthenticatedData(String url, String key) async {
    var responseJson;

    try {
      final response = await http.get(
        Uri.parse(_baseUrl + url),
        headers: {
          'Accept': 'application/json; charset=utf-8',
          "Authorization": "Token $key",
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future uploadImage(File imge, String path) async {
    final uri = Uri.parse(_baseUrl + 'api/$path');
    var request = http.MultipartRequest('POST', uri);
    var takenPicture = await http.MultipartFile.fromPath("file", imge.path);
    request.files.add(takenPicture);
    var response = await request.send();
    print(response);
  }

  Future<http.Response> postAuthenticatedData(
    String url,
    String key,
    int altId,
    dynamic data,
  ) async {
    var responseJson;
    String body = json.encode(data.toJson());
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Token $key",
          },
          body: body);
      print(response);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('You Are Not Connected To The Internet');
    }
    return responseJson;
  }

  Future<http.Response> patchAuthenticatedData(
      String url, String key, int altId, dynamic data) async {
    var responseJson;

    String body = json.encode(data.toJson());
    try {
      final response = await http.put(Uri.parse(_baseUrl + url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Token $key",
          },
          body: body);
      print(response);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 204:
        var responseJson = true;
        return responseJson;

      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class NonAuthenticatedApiProvider {
  final String _mobileBaseUrl =
      'http://dd05-2601-2c6-47e-4690-e9bb-3d97-d2ca-570a.ngrok.io';
  final String _baseUrl = "http://10.0.0.238:8000/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url), headers: {
        'Content-Type': 'application/json; charset=utf-8',
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));

        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class Response<T> {
  Status status;
  T? data;
  String? message;

  Response.loading(this.message) : status = Status.LOADING;
  Response.completed(this.data) : status = Status.COMPLETED;
  Response.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
