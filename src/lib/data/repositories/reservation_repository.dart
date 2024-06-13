import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ecopark/data/models/car_model.dart';
import '../../domain/interfaces/ireservation_repository.dart';

class ReservationRepositoryImpl implements IReservationRepository {
  static const _storage = FlutterSecureStorage();
  static final String _apiUrl = 'https://wa-dev-ecopark-api.azurewebsites.net/Reservation';
  static final String _tokenKey = 'token';

  @override
  Future<void> reserveParkingSpace(String parkingSpaceId, DateTime reservationDate) async {
    final String? token = await _storage.read(key: _tokenKey);
    if (token == null) {
      throw Exception('No token found');
    }

    final String carId = await getCarId(token);

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'parkingSpaceId': parkingSpaceId,
        'carId': carId,
        'reservationDate': reservationDate.toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to make reservation');
    }
  }

  @override
  Future<String> getCarId(String token) async {
    final Uri url = Uri.parse('https://wa-dev-ecopark-api.azurewebsites.net/Client');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'includeCars': 'true',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Car> cars = (data['cars'] as List).map((carJson) => Car.fromJson(carJson)).toList();
      if (cars.isNotEmpty) {
        return cars.first.id;
      } else {
        throw Exception('No cars found for the client');
      }
    } else {
      throw Exception('Failed to fetch client data');
    }
  }
}
