// lib/presentation/widgets/base_screen.dart

import 'package:ecopark/presentation/screens/find_parking_space_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/current_screen_provider.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';
import 'book_parking_spaces_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  static final List<Widget> _screens = [
    BookParkingSpacesScreen(),
    const FindParkingSpaceScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentScreenIndex = Provider.of<CurrentScreenProvider>(context).currentScreenIndex;

    return Scaffold(
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
