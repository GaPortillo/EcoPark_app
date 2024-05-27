// presentation/widgets/header_user_details.dart

import 'package:flutter/material.dart';

class HeaderUserDetails extends StatelessWidget {
  final String userName;
  final String userImagePath;
  final MainAxisAlignment alignment;

  const HeaderUserDetails({
    super.key,
    required this.userName,
    required this.userImagePath,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinhamento à esquerda
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(userImagePath),
        ),
        const SizedBox(width: 8),
        Text(userName),
      ],
    );
  }
}
