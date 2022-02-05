import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/Data_Layer/Models/authentication_models/userLogin_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

final _mobileBaseUrl =
    'http://dd05-2601-2c6-47e-4690-e9bb-3d97-d2ca-570a.ngrok.io';
final _base = "http://10.0.0.238:8000";
final _loginKeyEndpoint = "/auth/login/";
final _registerKeyEndpoint = '/auth/registration/';

final Uri _signinKeyURL = Uri.parse(_base + _loginKeyEndpoint);
final Uri _registrationKeyURL = Uri.parse(_base + _registerKeyEndpoint);

Future<Token> getKey(UserLogin userLogin) async {
  print(_signinKeyURL);
  final http.Response response = await http.post(
    _signinKeyURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Token> getKeyFromSignUp(UserSignUpLoginIn userSignUpLoginIn) async {
  print(_registrationKeyURL);
  final http.Response response = await http.post(
    _registrationKeyURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userSignUpLoginIn.toJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Token> getKeyFromConfirmation(
    UserConfirmationModel userConfirmationModel) async {
  print(_registrationKeyURL);
  final http.Response response = await http.post(
    _registrationKeyURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userConfirmationModel.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
