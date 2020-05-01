import 'dart:convert';

import 'package:form_validation_bloc/src/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:form_validation_bloc/src/firebase_server_data.dart'
    as serverData;

class UserProvider {
  final String _firebaseKey = serverData.firebaseKey;
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseKey',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {
        'ok': true,
        'token': decodedResp['idToken'],
      };
    } else {
      return {
        'ok': false,
        'message': decodedResp['error']['message'],
      };
    }
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseKey',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {
        'ok': true,
        'token': decodedResp['idToken'],
      };
    } else {
      return {
        'ok': false,
        'message': decodedResp['error']['message'],
      };
    }
  }
}
