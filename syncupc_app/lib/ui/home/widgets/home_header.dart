import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String location;
  final String profileImagePath;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.location,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        profileImagePath.startsWith('http') && profileImagePath.isNotEmpty;
    final initials = _getInitials(userName);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Nombre y ubicación
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.body2(userName),
            const SizedBox(height: 1),
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: AppColors.neutral900),
                const SizedBox(width: 4),
                AppText(
                  location,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.neutral900,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ],
        ),

        // Avatar: con imagen o iniciales
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary200,
          backgroundImage: hasPhoto ? NetworkImage(profileImagePath) : null,
          child: !hasPhoto
              ? Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
