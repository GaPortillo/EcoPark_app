import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecopark/data/models/location_model.dart';
import 'package:ecopark/data/repositories/location_repository.dart';
import 'package:ecopark/data/services/signalr_service.dart';
import '../widgets/parkingSpaces.dart';
import '../widgets/parking_location_dropdown.dart';

class BookParkingSpacesScreen extends StatefulWidget {
  @override
  _BookParkingSpacesScreenState createState() => _BookParkingSpacesScreenState();
}

class _BookParkingSpacesScreenState extends State<BookParkingSpacesScreen> {
  final LocationRepository _locationRepository = LocationRepositoryImpl();
  List<Location> _locations = [];
  bool _isLoading = true;
  Location? _selectedLocation;
  SignalRService? _signalRService;

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    try {
      final locations = await _locationRepository.listLocations(null, true);
      setState(() {
        _locations = locations;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onLocationChanged(Location? location) {
    setState(() {
      _selectedLocation = location;
    });

    if (_selectedLocation != null) {
      _startSignalRConnection(_selectedLocation!.id);

    }
  }

  Future<void> _startSignalRConnection(String locationId) async {
    _signalRService = Provider.of<SignalRService>(context, listen: false);
    await _signalRService?.startConnection(locationId);
  }

  @override
  void dispose() {
    _signalRService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ParkingLocationDropdown(
              locations: _locations,
              onChanged: _onLocationChanged,
            ),
            SizedBox(height: 20),
            if (_selectedLocation != null)
              Text(
                'Taxa de Reserva: R\$ ${_selectedLocation!.reservationFeeRate > 0 ? _selectedLocation!.reservationFeeRate.toString() : "Não possui"}  '
                    'Taxa de Atraso: R\$ ${_selectedLocation!.cancellationFeeRate > 0 ? _selectedLocation!.cancellationFeeRate.toString() : "Não possui"}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            if (_selectedLocation != null)
              ParkingSpaces(), // Adicionando o widget ParkingSpaces aqui
          ],
        ),
      ),
    );
  }
}
