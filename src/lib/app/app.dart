// lib/app/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/services/auth_service.dart';
import 'app_routes.dart';
import 'app_theme.dart';
import '../presentation/providers/current_screen_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final hasToken = authService.getToken() != null;

    return MaterialApp(
      theme: AppTheme.lightTheme,
      initialRoute: hasToken ? AppRoutes.base : AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
