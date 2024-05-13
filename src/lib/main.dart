import 'package:flutter/material.dart';
import 'package:ecopark/Widgets/header.dart';
import 'package:ecopark/Widgets/footer.dart';
import 'package:ecopark/Widgets/Pages/bookParkingSpace.dart';
import 'package:ecopark/Widgets/Pages/checkpoint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Rota inicial, se precisar
      routes: {
        '/': (context) => const Checkpoint(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Header(),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/bookParkingSpace'); // Navega para a página BookParkingSpacePage
          },
          child: const Text('Reservar Vaga de Estacionamento'),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
