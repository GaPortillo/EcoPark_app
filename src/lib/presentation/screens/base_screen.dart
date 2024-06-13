import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/app_routes.dart';
import '../providers/current_screen_provider.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';
import 'book_parking_spaces_screen.dart';
import 'car_registration_screen.dart';
import 'checkpoint_screen.dart';
import 'find_parking_space_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  static final List<Widget> _screens = [
    BookParkingSpacesScreen(),
    const FindParkingSpaceScreen(),
    const CheckpointScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentScreenIndex = Provider.of<CurrentScreenProvider>(context).currentScreenIndex;

    return Scaffold(
      drawer: Drawer(  // Adicione o Drawer aqui
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF8DCBC8),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Cadastro de veículo'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.vehicleRegistration);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: _screens[currentScreenIndex],
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
