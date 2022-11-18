import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/auth_token.dart';

class AuthService {
  static const _authTokenKey = 'authToken';
  late final String? _apiKey;

  AuthService() {
    _apiKey = dotenv.env['FIREBASE_API_KEY'];
  }

  String _buildAuthUrl(String method) {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:$method?';
  }

  Future<AuthToken> _authenticate(
      String email, String password, String method) async {
    try {
      final url = Uri.parse('https://api-ct484.vercel.app/api/auth/$method');
      var response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "username": email,
            "password": password,
          }));

      final responseJson = json.decode(response.body);
      final authToken = _fromJson(responseJson);
      // _saveAuthToken(authToken);

      return authToken;
    } catch (error) {
      print(" >> error: " + error.toString());
      rethrow;
    }
  }

  Future<String> signup(String email, String password) async {
    try {
      final url = Uri.parse('https://api-ct484.vercel.app/api/auth/signup');
      var response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "username": email,
            "password": password,
          }));
      final responseJson = json.decode(response.body);
      // print(responseJson);
      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        return responseJson['message'];
      }
    } catch (error) {
      print(" >> error: " + error.toString());
      rethrow;
    }
  }

  Future<AuthToken> login(String email, String password) {
    return _authenticate(email, password, 'signin');
  }

  Future<void> _saveAuthToken(AuthToken authToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, json.encode(authToken.toJson()));
  }

  AuthToken _fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['accessToken'],
      userId: json['id'],
      username: json['username'],
    );
  }

  Future<AuthToken?> loadSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_authTokenKey)) {
      return null;
    }

    final savedToken = prefs.getString(_authTokenKey);

    final authToken = AuthToken.fromJson(json.decode(savedToken!));

    return authToken;
  }

  Future<void> clearSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_authTokenKey);
  }
}
