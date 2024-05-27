import 'package:flutter/material.dart';
import 'userButton.dart';

class HeaderUserDetails extends StatelessWidget {
  final String userName;
  final String userImagePath;
  final MainAxisAlignment alignment;

  const HeaderUserDetails({super.key,
    required this.userName,
    required this.userImagePath,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        UserButton(
          imagePath: userImagePath,
          onPressed: () {
            // Lógica para quando o botão de usuário for pressionado
          },
        ),
        const SizedBox(width: 15),
        Expanded(
          child: SizedBox(
            child: Text(
              userName,
              style: const TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
