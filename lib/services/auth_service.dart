import 'dart:convert';

import 'package:bus_ease/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> registerUser(User user) async {
    var url = Uri.parse('http://localhost:8080/api/register');

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
      }else{
        if(response.statusCode == 500){
          return {'success': false, 'message': "User already exists!"};
        }
        return {'success': false, 'message': "Registration failed!"};
      }

    } 
    catch (e) {
      return {'success': false, 'message': "Registration failed!"};
    }

  }
}
