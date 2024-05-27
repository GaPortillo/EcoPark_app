import 'package:flutter/material.dart';

import 'header_user_details.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      color: const Color(0xFF8DCBC8),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda

        children: [
          SizedBox(height: 20),
          HeaderUserDetails(
            userName: 'Gabriel Santos',
            userImagePath: 'assets/images/home.png',
            alignment: MainAxisAlignment.start, // Alinhamento à esquerda
          ),
        ],
      ),
    );
  }
}
