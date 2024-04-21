import 'dart:convert';
import 'package:bus_ease/models/user_data.dart';
import 'package:bus_ease/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;

class UserProvider extends ChangeNotifier {
  UserData? _user;
  UserData? get user => _user;
  final _storage = const FlutterSecureStorage();
  var baseUrl = "https://busease-server.vercel.app";

  Future<void> fetchUser() async {
    var url = Uri.parse("$baseUrl/api/user");
    var accessToken = await _storage.read(key: "access_token");

    if (accessToken == null) {
      return;
    }

    try {
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        _user = UserData.fromJson(res);
        notifyListeners();
      } else if (response.statusCode == 403) {
        AuthService authService = AuthService(userProvider: this);
        await authService.refreshToken();

        // Fetch the user again
        accessToken = await _storage.read(key: "access_token");
        response = await http.get(url, headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          _user = UserData.fromJson(res);
          notifyListeners();
        } else {
          throw Exception('Failed to load user data after refreshing token');
        }
      }
    } catch (e) {
      throw Exception('Failed to load user data');
    }
  }
}
