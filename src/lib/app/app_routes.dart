// lib/app/app_routes.dart

import 'package:flutter/material.dart';
import '../presentation/screens/base_screen.dart';
import '../presentation/screens/book_parking_spaces_screen.dart';
import '../presentation/screens/find_parking_space_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/search_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/register_screen.dart';  // Import the RegisterScreen

class AppRoutes {
  static const base = '/';
  static const home = '/bookParkingSpaces';
  static const login = '/login';
  static const findParkingSpace = '/findParkingSpace';
  static const settings = '/settings';
  static const register = '/register';

  static final Map<String, Widget Function(BuildContext)> routes = {
    base: (_) => const BaseScreen(),
    home: (_) => BookParkingSpacesScreen(),
    login: (_) => const LoginScreen(),
    findParkingSpace: (_) => const FindParkingSpaceScreen(),
    settings: (_) => const SettingsScreen(),
    register: (_) => RegisterScreen(),
  };
}
