import 'package:flutter/material.dart';
import '../../data/models/parking_space_model.dart'; // Import necessário

class ParkingSpaces extends StatefulWidget {
  final List<ParkingSpace> parkingSpaces; // Corrigido o tipo ParkingSpace

  const ParkingSpaces({super.key, required this.parkingSpaces});

  @override
  _ParkingSpacesState createState() => _ParkingSpacesState();
}

class _ParkingSpacesState extends State<ParkingSpaces> {
  ParkingSpace? _selectedParkingSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Escolha a vaga disponível desejada',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF8DCBC8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: widget.parkingSpaces.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final parkingSpace = widget.parkingSpaces[index];
              return _buildParkingSpace(parkingSpace);
            },
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedParkingSpace == null ? null : () {
              // Adicione a lógica de confirmação da vaga aqui
              print('Vaga selecionada: ${_selectedParkingSpace?.id}');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF8DCBC8),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Color(0xFF8DCBC8)),
              ),
            ),
            child: const Text(
              'Confirmar Vaga',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParkingSpace(ParkingSpace parkingSpace) {
    Color color;
    IconData icon;

    if (parkingSpace.isOccupied) {
      color = Colors.red;
      icon = Icons.block;
    } else {
      switch (parkingSpace.type) {
        case 'Electric':
          color = Colors.purple;
          icon = Icons.electric_car;
          break;
        case 'Combustion':
          color = Colors.green;
          icon = Icons.car_rental;
          break;
        case 'Pcd':
          color = Colors.lightBlue;
          icon = Icons.accessible;
          break;
        case 'Hybrid':
          color = Colors.purpleAccent;
          icon = Icons.electric_bike;
          break;
        default:
          color = Colors.grey;
          icon = Icons.car_rental;
      }
    }

    final isSelected = parkingSpace == _selectedParkingSpace;

    return GestureDetector(
      onTap: parkingSpace.isOccupied ? null : () {
        setState(() {
          _selectedParkingSpace = parkingSpace;
        });
      },
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.black : color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 18,
          color: color,
        ),
      ),
    );
  }
}
