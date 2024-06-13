// lib/domain/repositories/iauth_repository.dart

import '../../data/models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel> loginWithToken(String token);
  Future<void> storeCredentials(String email, String password);
  void scheduleTokenRefresh(String token);
}
