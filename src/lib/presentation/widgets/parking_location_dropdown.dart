import 'package:ecopark/data/models/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParkingLocationDropdown extends StatefulWidget {
  final List<Location> locations;
  final ValueChanged<Location?> onChanged;

  const ParkingLocationDropdown({
    Key? key,
    required this.locations,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ParkingLocationDropdownState createState() => _ParkingLocationDropdownState();
}

class _ParkingLocationDropdownState extends State<ParkingLocationDropdown> {
  Location? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Location>(
      decoration: const InputDecoration(
        labelText: 'Escolha o local onde deseja reservar sua vaga',
        border: OutlineInputBorder(),
      ),
      value: _selectedLocation,
      onChanged: (location) {
        setState(() {
          _selectedLocation = location;
        });
        widget.onChanged(location);
      },
      items: widget.locations.map((location) {
        return DropdownMenuItem<Location>(
          value: location,
          child: Text(location.name),
        );
      }).toList(),
    );
  }
}
