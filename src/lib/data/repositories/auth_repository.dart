// lib/data/repositories/auth_repository_impl.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../domain/interfaces/iauth_repository.dart';

const String _baseUrl = 'https://wa-dev-ecopark-api.azurewebsites.net';

class AuthRepositoryImpl implements IAuthRepository {
  final _storage = const FlutterSecureStorage();

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/Login'),
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

  @override
  Future<UserModel> loginWithToken(String token) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/Login'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Erro ao renovar o token');
    }
  }

  @override
  Future<void> logout() async {
    await _storage.deleteAll();
  }

  @override
  Future<void> storeCredentials(String email, String password) async {
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'password', value: password);
  }

  @override
  void scheduleTokenRefresh(String token) {
    Timer(const Duration(minutes: 25), () async {
      try {
        final email = await _storage.read(key: 'email');
        final password = await _storage.read(key: 'password');
        if (email != null && password != null) {
          await login(email, password);
        }
      } catch (e) {
        print('Erro na renovação do token: $e');
      }
    });
  }
}
