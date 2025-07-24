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
                      fontFamily: 'Nunito'),
                ),
              ],
            ),
          ],
        ),
        // Foto de perfil
        CircleAvatar(
          radius: 24,
          backgroundImage: profileImagePath.startsWith('http')
              ? NetworkImage(profileImagePath)
              : AssetImage(profileImagePath),
          onBackgroundImageError: (_, __) {
            debugPrint('Error loading profile image');
          },
        )
      ],
    );
  }
}
