// lib/data/repositories/client_repository_interface.dart

import 'dart:typed_data';

import '../../data/models/client_model.dart';

abstract class IClientRepository {
  Future<List<Client>> getClients();

  Future<void> insertClient(
      String firstName,
      String lastName,
      String email,
      String password,
      Uint8List? imageData,
      String? mimeType,
      String? imageName,
      );
  Future<Client> getClient();
}
