import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../app/app_theme.dart';
import '../../data/services/location_service.dart';
import '../widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class FindParkingSpaceScreen extends StatefulWidget {
  const FindParkingSpaceScreen({super.key});

  @override
  State<FindParkingSpaceScreen> createState() => _FindParkingSpaceScreenState();
}

class _FindParkingSpaceScreenState extends State<FindParkingSpaceScreen> {
  GoogleMapController? _mapController;
  LatLng? _initialCameraPosition;
  LatLng? _destination;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<List<LatLng>> _routes = [];
  int _selectedRouteIndex = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final locationService = Provider.of<LocationService>(context, listen: false);

      final currentLocation = await locationService.getCurrentLocation();
      final destination = await locationService.getDestinationLocation();
      setState(() {
        _initialCameraPosition = currentLocation;
        _destination = destination;

        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: currentLocation,
            infoWindow: const InfoWindow(title: 'Sua Localização'),
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('destination'),
            position: destination,
            infoWindow: const InfoWindow(title: 'Pátio Ciane Shopping'),
          ),
        );
      });

      await _getDirections();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _getDirections() async {
    if (_initialCameraPosition == null || _destination == null) {
      return;
    }

    try {
      final locationService = Provider.of<LocationService>(context, listen: false);
      final directions = await locationService.getDirections(_initialCameraPosition!, _destination!);
      setState(() {
        _routes = directions;
        if (_routes.isNotEmpty) {
          _selectedRouteIndex = 0;
          _polylines = {
            Polyline(
              polylineId: const PolylineId('directions'),
              points: _routes[_selectedRouteIndex],
              color: Colors.blue,
              width: 5,
            )
          };
        }
      });
    } catch (error) {
      print(error);
    }
  }

  void _onRouteSelected(int index) {
    setState(() {
      _selectedRouteIndex = index;
      _polylines = {
        Polyline(
          polylineId: const PolylineId('directions'),
          points: _routes[_selectedRouteIndex],
          color: Colors.blue,
          width: 5,
        )
      };
    });
  }

  void _traceRoute() {
    if (_initialCameraPosition == null || _destination == null) {
      return;
    }

    final Uri googleMapsUri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&origin=${_initialCameraPosition!.latitude},${_initialCameraPosition!.longitude}&destination=${_destination!.latitude},${_destination!.longitude}&travelmode=driving');
    launchUrl(googleMapsUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Para melhor localização trace sua rota',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: _initialCameraPosition == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _initialCameraPosition!,
                  zoom: 15,
                ),
                markers: _markers,
                polylines: _polylines,
              ),
            ),
            const SizedBox(height: 20),
            if (_routes.isNotEmpty)
              DropdownButton<int>(
                value: _selectedRouteIndex,
                items: List.generate(_routes.length, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text('Rota ${index + 1}'),
                  );
                }),
                onChanged: (value) {
                  if (value != null) {
                    _onRouteSelected(value);
                  }
                },
              ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Traçar rota da vaga',
              onPressed: _traceRoute,
              backgroundColor: Colors.white,
              textColor: AppTheme.primaryColor,
              borderRadius: 8.0,
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Verificar reserva',
              onPressed: () {
                // Funcionalidade de verificar reserva ainda não implementada
              },
              backgroundColor: Colors.white,
              textColor: AppTheme.primaryColor,
              borderRadius: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
