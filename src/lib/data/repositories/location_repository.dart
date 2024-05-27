import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../data/models/location_model.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocation(String id);
  Future<List<Location>> listLocations(List<String>? locationIds, bool includeParkingSpaces);

}

class LocationRepositoryImpl implements LocationRepository {
  static const _storage = FlutterSecureStorage();
  final String _apiUrl = 'https://wa-dev-ecopark-api.azurewebsites.net/Location';
  final String _tokenKey = 'token';


  @override
  Future<List<Location>> getLocation(String id) async {
    final String? token = await _storage.read(key: _tokenKey);
    final Uri url = Uri.parse('$_apiUrl?locationId=$id');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Location.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
}

  @override
  Future<List<Location>> listLocations(List<String>? locationIds, bool includeParkingSpaces) async {
    final String? token = await _storage.read(key: _tokenKey);
    final Uri url = Uri.parse('$_apiUrl/list');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'locationIds': locationIds ?? [],
        'includeParkingSpaces': includeParkingSpaces,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Location.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
}
