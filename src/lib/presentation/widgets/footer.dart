// lib/presentation/widgets/footer.dart

import 'package:flutter/material.dart';
import 'footer_button.dart';
import '../../app/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      height: 60,
      color: AppTheme.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FooterButton(icon: Icons.smartphone, screenIndex: 0),
          FooterButton(icon: Icons.location_on, screenIndex: 1),
          FooterButton(icon: Icons.card_giftcard, screenIndex: 2),
        ],
      ),
    );
  }
}
