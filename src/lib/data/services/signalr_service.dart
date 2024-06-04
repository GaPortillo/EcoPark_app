import 'dart:async';
import 'package:signalr_core/signalr_core.dart';

class SignalRService {
  late HubConnection _hubConnection;
  final StreamController<List<dynamic>> _receivedDataController = StreamController<List<dynamic>>.broadcast();

  Stream<List<dynamic>> get receivedData => _receivedDataController.stream;

  Future<void> startConnection(String locationId) async {
    _hubConnection = HubConnectionBuilder()
        .withUrl('https://wa-dev-ecopark-api.azurewebsites.net/parkingSpaceHub',
        HttpConnectionOptions(
            logging: (level, message) => print(message),
            transport: HttpTransportType.webSockets))
        .build();

    await _hubConnection.start();
    print('Conectado ao hub SignalR de status das vagas de estacionamento.');

    _hubConnection.on('ReceiveParkingSpaces', (data) {
      _receivedDataController.add(data?[0] ?? []);
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

  Future<void> getParkingSpaces(String locationId) async {
    if (_hubConnection.state == HubConnectionState.connected) {
      try {
        await _hubConnection.invoke('GetParkingSpaces', args: [locationId]);
      } catch (err) {
        print('Erro ao chamar o método GetParkingSpaces: $err');
      }
    } else {
      print('Conexão não está ativa.');
    }
  }

  void dispose() {
    _hubConnection.stop();
    _receivedDataController.close();
  }
}
