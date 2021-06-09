import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mymovies_app/src/model/login_model.dart';

import 'package:mymovies_app/src/shared_preferences/shared_preferences.dart';

class UserService {
  final String _url = 'https://reqres.in/api/login';
  final _preferences = new UserPreferences();

  Future<LoginResponseModel> logIn(LoginRequestModel loginRequestModel) async {
    final response = await http.post(
      Uri.parse(_url),
      body: loginRequestModel.toJson()
    );

    print(response.body);

    var result = LoginResponseModel.fromJson(json.decode(response.body));
    
    if (response.statusCode == 200) {
      _preferences.token = result.token;
    }
    else _preferences.token = '';
    
    return result;
    
  }
}