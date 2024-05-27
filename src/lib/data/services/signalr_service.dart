// lib/data/services/signalr_service.dart

import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRService {
  final HubConnection _hubConnection;
  final _connectionStateController = ValueNotifier<HubConnectionState>(HubConnectionState.disconnected);

  SignalRService(this._hubConnection);

  ValueNotifier<HubConnectionState> get connectionState => _connectionStateController;

  Future<void> startConnection() async {
    _hubConnection.onclose((error) { // Correção aqui
      _connectionStateController.value = HubConnectionState.disconnected;
      if (error != null) {
        print('Conexão encerrada: $error');
      }
    });

    await _hubConnection.start();
    _connectionStateController.value = HubConnectionState.connected;
    print('Conectado ao Hub SignalR.');
  }

  Future<void> stopConnection() async {
    await _hubConnection.stop();
    _connectionStateController.value = HubConnectionState.disconnected;
    print('Desconectado do Hub SignalR.');
  }

  Future<void> waitForConnection() async {
    while (_connectionStateController.value != HubConnectionState.connected) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  HubConnection get channel => _hubConnection;
}
