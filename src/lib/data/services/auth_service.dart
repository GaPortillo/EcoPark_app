// lib/data/services/auth_service.dart

import 'package:ecopark/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _emailKey = 'email';
  static const _passwordKey = 'password';
  static const _tokenKey = 'token';

  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<UserModel> login(String email, String password) async {
    return await _authRepository.login(email, password);
  }

  Future<void> saveCredentials(String email, String password) async {
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _passwordKey, value: password);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<Map<String, String>?> getCredentials() async {
    final email = await _storage.read(key: _emailKey);
    final password = await _storage.read(key: _passwordKey);
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  Future<void> autoLogin() async {
    final credentials = await getCredentials();
    if (credentials != null) {
      final userModel = await _authRepository.login(
        credentials['email']!,
        credentials['password']!,
      );
      await saveToken(userModel.token);
    }
  }

  Future<void> renewTokenPeriodically() async {
    final credentials = await getCredentials();
    if (credentials != null) {
      while (true) {
        await Future.delayed(const Duration(minutes: 25));
        final userModel = await _authRepository.login(
          credentials['email']!,
          credentials['password']!,
        );
        await saveToken(userModel.token);
      }
    }
  }
}
