import 'package:flutter/material.dart';
import '../presentation/screens/base_screen.dart';
import '../presentation/screens/book_parking_spaces_screen.dart';
import '../presentation/screens/car_registration_screen.dart';
import '../presentation/screens/find_parking_space_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/register_screen.dart';
import '../presentation/screens/checkpoint_screen.dart';

class AppRoutes {
  static const base = '/';
  static const home = '/bookParkingSpaces';
  static const login = '/login';
  static const findParkingSpace = '/findParkingSpace';
  static const settings = '/settings';
  static const register = '/register';
  static const checkpoint = '/checkpoint';
  static const vehicleRegistration = '/vehicleRegistration';  // Add Vehicle Registration route

  static final Map<String, Widget Function(BuildContext)> routes = {
    base: (_) => const BaseScreen(),
    home: (_) => BookParkingSpacesScreen(),
    login: (_) => const LoginScreen(),
    findParkingSpace: (_) => const FindParkingSpaceScreen(),
    register: (_) => RegisterScreen(),
    checkpoint: (_) => const CheckpointScreen(),
    vehicleRegistration: (_) => const CarRegistrationScreen(),  // Add Vehicle Registration route
  };
}
