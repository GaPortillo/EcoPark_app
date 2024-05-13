import 'package:flutter/material.dart';

class UserButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onPressed;

  const UserButton({super.key, required this.imagePath, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30, // Tamanho fixo
      height: 30, // Tamanho fixo
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: Ink.image(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          child: InkWell(
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}
