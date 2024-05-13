import 'package:flutter/material.dart';
import 'footerButtom.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      height: 60,
      color: Color(0xFF8DCBC8), // Defina a cor de fundo do BottomAppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FooterButton(icon: Icons.smartphone, url: 'https://sua-url.com/home'),
          FooterButton(icon: Icons.location_on, url: 'https://sua-url.com/search'),
          FooterButton(icon: Icons.card_giftcard, url: 'https://sua-url.com/settings'),
        ],
      ),
    );
  }
}
