import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/client_model.dart';
import '../../data/services/client_service.dart';
import 'header_user_details.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final clientService = Provider.of<ClientService>(context, listen: false);

    return FutureBuilder<Client>(
      future: clientService.fetchClient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 100,
            color: const Color(0xFF8DCBC8),
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 100,
            color: const Color(0xFF8DCBC8),
            child: const Center(child: Text('Erro ao carregar dados do cliente')),
          );
        } else {
          final client = snapshot.data!;
          final fullName = '${client.firstName} ${client.lastName}';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 100,
            color: const Color(0xFF8DCBC8),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  HeaderUserDetails(
                    userName: fullName,
                    userImagePath: 'assets/images/home.png',
                    alignment: MainAxisAlignment.start,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
