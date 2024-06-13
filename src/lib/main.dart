// lib/main.dart

import 'package:ecopark/data/repositories/reservation_repository.dart';
import 'package:ecopark/data/services/reservation_service.dart';
import 'package:ecopark/data/services/signalr_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/car_repository.dart';
import 'data/repositories/client_repository.dart';
import 'data/repositories/location_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/car_service.dart';
import 'data/services/client_service.dart';
import 'data/services/location_service.dart';
import 'domain/interfaces/icar_repository.dart';
import 'domain/interfaces/iclient_repository.dart';
import 'presentation/providers/current_screen_provider.dart';
import 'app/app_routes.dart';

void main() async {
  final authRepository = AuthRepositoryImpl();
  final authService = AuthService(authRepository);

  final locationRepository = LocationRepositoryImpl();
  final locationService = LocationService(locationRepository);

  final reservationRepository = ReservationRepositoryImpl();
  final reservationService = ReservationService(reservationRepository);

  final IClientRepository clientRepository = ClientRepository();
  final ClientService clientService = ClientService(clientRepository);

  final ICarRepository carRepository = CarRepository();
  final CarService carService = CarService(carRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrentScreenProvider(-1),
        ),
        Provider.value(value: authRepository),
        Provider.value(value: authService),
        Provider.value(value: locationRepository),
        Provider.value(value: locationService),
        Provider.value(value: reservationService),
        Provider.value(value: clientService),
        Provider.value(value: carService),
        Provider(create: (_) => SignalRService()),
      ],
      child: const App(),
    ),
  );

  authService.renewTokenPeriodically();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final currentScreenIndex = Provider.of<CurrentScreenProvider>(context).currentScreenIndex;
    return MaterialApp(
      theme: AppTheme.lightTheme,
      initialRoute: currentScreenIndex == -1 ? AppRoutes.login : AppRoutes.base, // Rota inicial baseada no índice
      routes: AppRoutes.routes,
    );
  }
}
