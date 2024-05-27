import 'dart:async';
import 'package:signalr_core/signalr_core.dart';

class SignalRService {
  late HubConnection _hubConnection;
  final StreamController<List<dynamic>> _receivedDataController = StreamController<List<dynamic>>.broadcast();

  Stream<List<dynamic>> get receivedData => _receivedDataController.stream;

  Future<void> startConnection(String locationId) async {
    _hubConnection = HubConnectionBuilder()
        .withUrl('https://wa-dev-ecopark-api.azurewebsites.net/parkingSpaceHub?locationId=$locationId',
        HttpConnectionOptions(
            logging: (level, message) => print(message),
            transport: HttpTransportType.webSockets))
        .build();

    await _hubConnection.start();
    print('Conectado ao hub SignalR de status das vagas de estacionamento.');

    _hubConnection.on('ReceiveParkingSpaces', (data) {
      _receivedDataController.add(data ?? []);
    });

    await getParkingSpaces(locationId);

    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (_hubConnection.state == HubConnectionState.connected) {
        await getParkingSpaces(locationId);
      } else {
        timer.cancel();
      }
    });
  }

  Future<List<dynamic>> getParkingSpaces(String locationId) async {
    if (_hubConnection.state == HubConnectionState.connected) {
      try {
        final result = await _hubConnection.invoke('GetParkingSpaces', args: [locationId]);
        if (result is List<dynamic>) {
          return result;
        } else {
          print('Aviso: O resultado da invocação não é uma lista: $result');
          return [];
        }
      } catch (err) {
        print('Erro ao chamar o método GetParkingSpaces: $err');
        return [];
      }
    } else {
      print('Conexão não está ativa.');
      return [];
    }
  }

  void dispose() {
    _hubConnection.stop();
    _receivedDataController.close();
  }
}
