// presentation/widgets/footer_button.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/current_screen_provider.dart';

class FooterButton extends StatelessWidget {
  final IconData icon;
  final int screenIndex;

  const FooterButton({
    super.key,
    required this.icon,
    required this.screenIndex,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: Colors.white,
      onPressed: () {
        Provider.of<CurrentScreenProvider>(context, listen: false)
            .changeScreen(screenIndex);
      },
    );
  }
}
