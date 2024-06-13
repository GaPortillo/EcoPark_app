// lib/data/repositories/client_repository.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../domain/interfaces/iclient_repository.dart';
import '../models/client_model.dart';

class ClientRepository implements IClientRepository {
  static const _storage = FlutterSecureStorage();
  final String _baseUrl = 'https://wa-dev-ecopark-api.azurewebsites.net/Client';
  final String _tokenKey = 'token';

  @override
  Future<List<Client>> getClients() async {
    final url = Uri.parse(_baseUrl + '/list');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'clientIds': [], 'includeCars': false}),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((clientJson) => Client.fromJson(clientJson)).toList();
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception('Erro ao obter os clientes da API: ${errorData['error'] ?? 'Erro desconhecido'}');
      }
    } catch (e) {
      throw Exception('Erro na comunicação com a API: $e');
    }
  }

  @override
  Future<void> insertClient(
      String firstName,
      String lastName,
      String email,
      String password,
      Uint8List? imageData,
      String? mimeType,
      String? imageName,
      ) async {
    final url = Uri.parse(_baseUrl).replace(queryParameters: {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });

    var request = http.MultipartRequest('POST', url);

    if (imageData != null) {
      var multipartFile = http.MultipartFile.fromBytes(
        'image',
        imageData,
        filename: imageName ?? 'image.jpg',
        contentType: MediaType.parse(mimeType ?? 'image/jpeg'),
      );
      request.files.add(multipartFile);
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Cliente cadastrado com sucesso!');
      } else {
        final responseString = await response.stream.bytesToString();
        final errorData = jsonDecode(responseString);
        throw Exception('Erro ao cadastrar cliente: ${errorData['error'] ?? 'Erro desconhecido'}');
      }
    } catch (e) {
      throw Exception('Erro na comunicação com a API: $e');
    }
  }

  @override
  Future<Client> getClient() async {
    final String? token = await _storage.read(key: _tokenKey);
    final Uri url = Uri.parse(_baseUrl).replace(queryParameters: {
      'includeCars': 'true',
    });
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Client.fromJson(data);
    } else {
      throw Exception('Failed to load client data');
    }
  }
}
