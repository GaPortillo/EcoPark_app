// lib/main.dart

import 'package:ecopark/data/services/signalr_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/location_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/location_service.dart';
import 'presentation/providers/current_screen_provider.dart';
import 'app/app_routes.dart';

void main() async {
  final authRepository = AuthRepositoryImpl();
  final authService = AuthService(authRepository);

  final locationRepository = LocationRepositoryImpl();
  final locationService = LocationService(locationRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrentScreenProvider(-1), // Índice inicial baseado no token
        ),
        Provider.value(value: authRepository),
        Provider.value(value: authService),
        Provider.value(value: locationRepository),
        Provider.value(value: locationService),
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
