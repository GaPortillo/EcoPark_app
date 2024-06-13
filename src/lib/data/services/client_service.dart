// lib/data/services/client_service.dart
import 'dart:typed_data';

import '../../domain/interfaces/iclient_repository.dart';
import '../models/client_model.dart';

class ClientService {
  final IClientRepository _clientRepository;

  ClientService(this._clientRepository);

  Future<Client> fetchClient() {
    return _clientRepository.getClient();
  }

  Future<List<Client>> fetchClients() {
    return _clientRepository.getClients();
  }

  Future<void> addClient(
      String firstName,
      String lastName,
      String email,
      String password,
      Uint8List? imageData,
      String? mimeType,
      String? imageName,
      ) {
    return _clientRepository.insertClient(
      firstName,
      lastName,
      email,
      password,
      imageData,
      mimeType,
      imageName,
    );
  }
}
