// lib/data/repositories/car_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/interfaces/icar_repository.dart';
import '../models/car_model.dart';
import '../models/client_model.dart';
import '../models/query_models/car_query_model.dart';

class CarRepository implements ICarRepository {
  static const _storage = FlutterSecureStorage();
  final String _baseUrl = 'https://wa-dev-ecopark-api.azurewebsites.net/Car';

  @override
  Future<void> insertCar(CarQueryModel car) async {
    final String? token = await _storage.read(key: 'token');
    final url = Uri.parse(_baseUrl);

    var a = jsonEncode(car.toJson());
    var b = car.toJson();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },

      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      throw Exception('Erro ao cadastrar carro: ${errorData['error'] ?? 'Erro desconhecido'}');
    }
  }

  @override
  Future<void> updateCar(String carId, CarQueryModel car) async {
    final String? token = await _storage.read(key: 'token');

    final Uri url = Uri.parse(_baseUrl).replace(queryParameters: {
      'id': carId,
    });

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      throw Exception('Erro ao atualizar carro: ${errorData['error'] ?? 'Erro desconhecido'}');
    }
  }

  @override
  Future<List<Car>?> getCars() async {
    final String? token = await _storage.read(key: 'token');
    final url = Uri.parse('https://wa-dev-ecopark-api.azurewebsites.net/Client?includeCars=true');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final client = Client.fromJson(data);
      return client.cars;
    } else {
      throw Exception('Failed to load cars');
    }
  }
}
