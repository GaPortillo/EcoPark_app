import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/services/auth_service.dart';
import 'presentation/providers/current_screen_provider.dart';
import 'app/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authRepository = AuthRepositoryImpl();
  final authService = AuthService(authRepository);

  // Verifica a existência do token
  final hasToken = await authService.getToken() != null;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrentScreenProvider(hasToken ? 0 : -1), // Índice inicial baseado no token
        ),
        Provider.value(value: authRepository),
        Provider.value(value: authService),
      ],
      child: const App(),
    ),
  );

  if (hasToken) {
    authService.renewTokenPeriodically();
  }
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
