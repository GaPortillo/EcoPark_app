import 'dart:convert';

import 'package:ecopark/data/repositories/location_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationService {
  final Location _location = Location();
  final String _apiKey = 'AIzaSyCq3GE9A36O9KHksrtgCg0YRt14BnRS5YY';
  final LocationRepository _locationRepository;

  LocationService(this._locationRepository);

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception('Service not enabled');
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Permission not granted');
      }
    }

    final locationData = await _location.getLocation();
    return LatLng(locationData.latitude!, locationData.longitude!);
  }

  Future<LatLng> getDestinationLocation() async {

    final locations = await _locationRepository.listLocations(null,false);

    final String searchTerm = 'Patio Ciane Shopping Sorocaba';
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$searchTerm&inputtype=textquery&fields=formatted_address,name,geometry&key=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['candidates'].isNotEmpty) {
        final location = data['candidates'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return LatLng(lat, lng);
      } else {
        throw Exception('No candidates found.');
      }
    } else {
      throw Exception('Failed to fetch location');
    }
  }

  Future<List<List<LatLng>>> getDirections(LatLng origin, LatLng destination) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<List<LatLng>> routes = [];

      if (data['routes'].isNotEmpty) {
        for (var route in data['routes']) {
          final points = _decodePolyline(route['overview_polyline']['points']);
          routes.add(points);
        }
      }

      return routes;
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<LatLng> _decodePolyline(String poly) {
    List<LatLng> points = [];
    int index = 0, len = poly.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = poly.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = poly.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}
