import 'package:flutter/material.dart';
import 'package:ecopark/Widgets/header.dart';
import 'package:ecopark/Widgets/footer.dart';
import 'package:ecopark/Widgets/parkingSpaces.dart'; // Importe o widget ParkingSpaces
import 'package:ecopark/Widgets/reservation.dart'; // Importe o widget Reservation


class BookParkingSpacePage extends StatelessWidget {
  const BookParkingSpacePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Header(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(
                  value: 'item1',
                  child: Row(
                    children: [
                      Icon(Icons.directions_car),
                      SizedBox(width: 8),
                      Text('Vaga 1'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'item2',
                  child: Row(
                    children: [
                      Icon(Icons.directions_car),
                      SizedBox(width: 8),
                      Text('Vaga 2'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: 'Escolha a vaga',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF8DCBC8)),
                ),
                border: OutlineInputBorder(), // Define uma borda padrão
              ),
            ),
            const SizedBox(height: 16),
            const Text('Taxa de Reserva: R\$ 5,00            Taxa de Atraso: Não possui'),
            const SizedBox(height: 16),
            const Expanded(
              child: Center(
                child: ParkingSpaces(),
              ),
            ),
            const Reservation(), // Adiciona o widget Reservation
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Adicione a lógica do botão aqui
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF8DCBC8), backgroundColor: Colors.white, // Cor do texto do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Color(0xFF8DCBC8)), // Cor da borda do botão
                  ),
                ),
                child: const Text(
                  'Registrar Vaga',
                  style: TextStyle(
                    fontFamily: 'Arial', // Fonte Arial
                    fontSize: 16, // Tamanho da fonte 16
                    fontWeight: FontWeight.bold, // Texto em negrito
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,)

          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
