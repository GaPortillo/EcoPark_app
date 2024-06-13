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
      mainAxisAlignment: alignment,
      children: [
        GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer(); // Open Drawer on tap
          },
          child: CircleAvatar(
            backgroundImage: AssetImage(userImagePath),
          ),
        ),
        const SizedBox(width: 8),
        Text(userName),
      ],
    );
  }
}
