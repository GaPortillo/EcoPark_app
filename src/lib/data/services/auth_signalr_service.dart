// lib/data/services/auth_signalr_service.dart

import 'package:signalr_core/signalr_core.dart';
import '../models/user_model.dart';

class AuthSignalRService {
  final HubConnection _hubConnection;

  AuthSignalRService(this._hubConnection);

  Future<UserModel?> login(String email, String password) async {
    try {
      final result = await _hubConnection.invoke(
        'Login',
        args: [
          {'email': email, 'password': password}
        ],
      );

      if (result != null) {
        return UserModel.fromJson(result[0]); // Assuming the response is a Map
      } else {
        return null; // Login failed
      }
    } catch (e) {
      print('Erro ao fazer login via SignalR: $e');
      rethrow; // Repassa a exceção para ser tratada na camada superior
    }
  }
}
