import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String avatarUrl;

  const UserHeader({
    super.key,
    required this.userName,
    required this.timeAgo,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.body1(
              userName,
            ),
            AppText.body1(
              timeAgo,
            ),
          ],
        ),
      ],
    );
  }
}
