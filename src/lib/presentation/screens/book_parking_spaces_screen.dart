import 'package:ecopark/domain/interfaces/ilocation_repository.dart';
import 'package:flutter/material.dart';
import '../../data/models/location_model.dart';
import 'package:ecopark/data/repositories/location_repository.dart';
import '../widgets/parkingSpaces.dart';
import '../widgets/parking_location_dropdown.dart';
import '../../data/models/parking_space_model.dart';
import '../widgets/reservation.dart';

class BookParkingSpacesScreen extends StatefulWidget {
  @override
  _BookParkingSpacesScreenState createState() => _BookParkingSpacesScreenState();
}

class _BookParkingSpacesScreenState extends State<BookParkingSpacesScreen> {
  final ILocationRepository _locationRepository = LocationRepositoryImpl();
  List<Location> _locations = [];
  bool _isLoading = true;
  Location? _selectedLocation;
  List<ParkingSpace> _parkingSpaces = [];
  ParkingSpace? _selectedParkingSpace;

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
      _selectedParkingSpace = null;
    });

    if (_selectedLocation != null) {
      _fetchParkingSpaces(_selectedLocation!.id);
    }
  }

  void _onParkingSpaceSelected(ParkingSpace? parkingSpace) {
    setState(() {
      _selectedParkingSpace = parkingSpace;
    });
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
              ParkingSpaces(
                parkingSpaces: _parkingSpaces,
                onParkingSpaceSelected: _onParkingSpaceSelected,
              ),
            if (_selectedParkingSpace != null)
              Reservation(parkingSpaceId: _selectedParkingSpace!.id), // Passar parkingSpaceId para Reservation
          ],
        ),
      ),
    );
  }
}
