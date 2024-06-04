import 'package:flutter/material.dart';
import '../../data/models/location_model.dart';
import 'package:ecopark/data/repositories/location_repository.dart';
import '../widgets/parkingSpaces.dart';
import '../widgets/parking_location_dropdown.dart';
import '../../data/models/parking_space_model.dart'; // Import necessário
import '../widgets/reservation.dart'; // Importe o novo widget

class BookParkingSpacesScreen extends StatefulWidget {
  @override
  _BookParkingSpacesScreenState createState() => _BookParkingSpacesScreenState();
}

class _BookParkingSpacesScreenState extends State<BookParkingSpacesScreen> {
  final LocationRepository _locationRepository = LocationRepositoryImpl();
  List<Location> _locations = [];
  bool _isLoading = true;
  Location? _selectedLocation;
  List<ParkingSpace> _parkingSpaces = [];

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    try {
      final locations = await _locationRepository.listLocations(null, false); // Alterado para false
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
      _parkingSpaces = [];
    });

    if (_selectedLocation != null) {
      _fetchParkingSpaces(_selectedLocation!.id);
    }
  }

  Future<void> _fetchParkingSpaces(String locationId) async {
    try {
      final locations = await _locationRepository.listLocations([locationId], true); // Enviando locationId e definindo includeParkingSpaces como true
      if (locations.isNotEmpty) {
        setState(() {
          _parkingSpaces = locations.first.parkingSpaces ?? [];
        });
      }
    } catch (error) {
      setState(() {
        _parkingSpaces = [];
      });
    }
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
              ParkingSpaces(parkingSpaces: _parkingSpaces),
            if (_selectedLocation != null)
              Reservation(), // Adiciona o widget Reservation aqui
          ],
        ),
      ),
    );
  }
}
