import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const FooterButton({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: Colors.white,
      onPressed: () {
        // Navegue para a URL quando o botão for pressionado
        // Aqui você pode usar qualquer método de navegação, como Navigator.pushNamed
        // ou launch(url) do package url_launcher
      },
    );
  }
}
