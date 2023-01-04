import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/Data_Layer/Models/authentication_models/userLogin_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

final _mobileBaseUrl =
    "http://866a-2601-2c6-500-16f0-c174-be6e-1dd6-f799.ngrok.io";
final _base = "http://127.0.0.1:8000";
final _loginKeyEndpoint = "/auth/login/";
final _registerKeyEndpoint = "/auth/registration/";

final Uri _signinKeyURL = Uri.parse(_mobileBaseUrl + _loginKeyEndpoint);
final Uri _registrationKeyURL =
    Uri.parse(_mobileBaseUrl + _registerKeyEndpoint);

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
