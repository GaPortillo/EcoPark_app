// lib/data/services/login_screen_service.dart

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class LoginScreenService {
  final String _baseUrl = 'https://wa-dev-ecopark-api.azurewebsites.net/Login';
  final _storage = const FlutterSecureStorage();

  Future<UserModel> login(String email, String password) async {
    final response = await http.put(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      final user = UserModel.fromJson(userData);
      await _storage.write(key: 'token', value: user.token);
      return user;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception('Falha no login: ${errorData['message']}');
    }
  }
}