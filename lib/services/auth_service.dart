import 'dart:convert';

import 'package:bus_ease/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final _storage = const FlutterSecureStorage();
  var baseUrl = "https://busease-server.vercel.app";

  Future<bool> isLoggedIn() async {
    var token = await _storage.read(key: "access_token");
    if (token != null && token.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>> registerUser(User user) async {
    var url = Uri.parse("$baseUrl/api/register");

    var body = jsonEncode({
      'firstName': user.firstName,
      'middleName': user.middleName,
      'lastName': user.lastName,
      'dob': user.dob.toIso8601String(),
      'gender': user.gender,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'aadharCardNumber': user.aadharCardNumber,
      'password': user.password,
      'role': user.role,
    });

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      var res = jsonDecode(response.body);
      // store the access and refresh tokens in secure storage
      if (response.statusCode == 200) {
        await _storage.write(key: "access_token", value: res['access_token']);
        await _storage.write(key: "refresh_token", value: res['refresh_token']);

        return {'success': true, 'message': 'Registration successful'};
      } else {
        if (response.statusCode == 500) {
          return {'success': false, 'message': "User already exists!"};
        }
        return {'success': false, 'message': "Registration failed!"};
      }
    } catch (e) {
      return {'success': false, 'message': "Registration failed!"};
    }
  }

  Future<Map<String, dynamic>> loginUser(
      {String? email,
      String? phoneNumber,
      String? aadharCardNumber,
      required String password}) async {
    var url = Uri.parse("$baseUrl/api/login");

    var body = jsonEncode({
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (aadharCardNumber != null) 'aadharCardNumber': aadharCardNumber,
      'password': password,
    });

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      var res = jsonDecode(response.body);
      // store the access and refresh tokens in secure storage
      if (response.statusCode == 200) {
        await _storage.write(key: "access_token", value: res['access_token']);
        await _storage.write(key: "refresh_token", value: res['refresh_token']);

        return {'success': true, 'message': 'Login successful'};
      } else {
        return {'success': false, 'message': "Login failed!"};
      }
    } catch (e) {
      return {'success': false, 'message': "Login failed!"};
    }
  }

  Future<Map<String,dynamic>> logoutUser() async {
    var url = Uri.parse("$baseUrl/api/logout");

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await _storage.read(key: "access_token")}"
        },
        body: jsonEncode({
          'refresh_token': await _storage.read(key: "refresh_token"),
        }),
      );
      if (response.statusCode == 200) {
        await _storage.delete(key: "access_token");
        await _storage.delete(key: "refresh_token");
        return {'success': true, 'message': 'Logout successful'};
      } else {
        return {'success': false, 'message': "Logout failed!"};
      }
    } catch (e) {
      return {'success': false, 'message': "Logout failed!"};
    }
  }

  Future<bool> refreshToken() async {
    var url = Uri.parse("$baseUrl/api/refresh");

    var body = jsonEncode({
      'refresh_token': await _storage.read(key: "refresh_token"),
    });

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await _storage.write(key: "access_token", value: res['access_token']);
        await _storage.write(key: "refresh_token", value: res['refresh_token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }

  }
}
