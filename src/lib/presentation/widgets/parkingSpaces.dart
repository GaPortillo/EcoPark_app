import 'package:flutter/material.dart';

class ParkingSpaces extends StatelessWidget {
  const ParkingSpaces({super.key});

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildParkingColumn(1, 2),
              const SizedBox(width: 8),
              _buildParkingColumn(3, 4),
              const SizedBox(width: 8),
              _buildParkingColumn(5, 6),
            ],
          ),
        ),
        const SizedBox(height: 16),
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
              'Confirmar Vaga',
              style: TextStyle(
                fontFamily: 'Arial', // Fonte Arial
                fontSize: 16, // Tamanho da fonte 16
                fontWeight: FontWeight.bold, // Texto em negrito
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParkingColumn(int start, int end) {
    return Column(
      children: [
        for (var i = 0; i < 8; i++)
          Row(
            children: [
              for (var j = start; j <= end; j++)
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.car_rental,
                    size: 18,
                    color: Colors.green,
                  ),
                ),
              const SizedBox(width: 8), // Espaçamento entre as colunas
            ],
          ),
        const SizedBox(height: 8), // Espaçamento entre as linhas
      ],
    );
  }
}
