import 'package:flutter/material.dart';
import 'headerUserDetails.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 100, // Altura do cabeçalho
      color: const Color(0xFF8DCBC8), // Cor de fundo do cabeçalho (você pode ajustar conforme necessário)
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          SizedBox(height: 20),
          HeaderUserDetails(
            userName: 'Gabriel Santos',
            userImagePath: 'Assets/Images/home.png',
            alignment: MainAxisAlignment.center,
          ),
      ], // Children
      ),
    );
  }
}
