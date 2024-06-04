import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/client_model.dart';

class ClientRepository {
  final String _baseUrl =
      'https://wa-dev-ecopark-api.azurewebsites.net/Client'; // URL base da API

  Future<List<Client>> getClients() async {
    final url = Uri.parse(_baseUrl + '/list');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'clientIds': [], 'includeCars' : false}),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((clientJson) => Client.fromJson(clientJson))
            .toList();
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
            'Erro ao obter os clientes da API: ${errorData['error'] ?? 'Erro desconhecido'}');
      }
    } catch (e) {
      throw Exception('Erro na comunicação com a API: $e');
    }
  }

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
      String? filename = imageName;

      var multipartFile = http.MultipartFile.fromBytes(
        'image', // Nome do campo para a imagem
        imageData,
        filename: filename, // Ou o nome original do arquivo
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
        throw Exception(
            'Erro ao cadastrar cliente: ${errorData['error'] ?? 'Erro desconhecido'}');
      }
    } catch (e) {
      throw Exception('Erro na comunicação com a API: $e');
    }
  }
}