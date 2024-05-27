// lib/data/repositories/auth_repository.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../data/services/auth_signalr_service.dart';
import 'package:signalr_core/signalr_core.dart';
import '../models/user_model.dart';
import '../services/signalr_service.dart';

const String _baseUrl = 'https://apim-dev-ecopark-api.azure-api.net';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithToken(String token);

}

class AuthRepositoryImpl implements AuthRepository {
  final _storage = const FlutterSecureStorage();

  late SignalRService _signalRService;
  late AuthSignalRService _authSignalRService;

  AuthRepositoryImpl() {
    final hubConnection = HubConnectionBuilder()
        .withUrl('https://apim-dev-ecopark-api.azure-api.net/parkingSpaceHub', HttpConnectionOptions(
      transport: HttpTransportType.webSockets,
      skipNegotiation: true, // Skip the negotiation step
    ))
        .withAutomaticReconnect()
        .build();

    _signalRService = SignalRService(hubConnection);
    _authSignalRService = AuthSignalRService(_signalRService.channel!);
    _signalRService.startConnection();
  }

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
      return data['token'];
    } else {
      throw Exception('Erro ao renovar o token');
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<void> storeCredentials(String email, String password) async {
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'password', value: password);
  }

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
