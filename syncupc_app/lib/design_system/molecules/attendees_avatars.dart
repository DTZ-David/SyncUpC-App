import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class AttendeesAvatars extends StatelessWidget {
  final List<String> avatars;
  final int totalAttendees;
  final double avatarRadius; // Nuevo parámetro

  const AttendeesAvatars({
    super.key,
    required this.avatars,
    required this.totalAttendees,
    this.avatarRadius = 12, // Valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    if (avatars.isEmpty) return const SizedBox.shrink();

    final int avatarsToShow = avatars.length > 3 ? 3 : avatars.length;
    final int remainingCount = totalAttendees - 3;
    final bool showPlusCircle = totalAttendees > 3;

    final double overlap = avatarRadius; // más overlap si el tamaño es mayor
    final double extraCircleWidth = avatarRadius * 2;

    final double width = showPlusCircle
        ? (avatarsToShow * overlap) + extraCircleWidth
        : (avatarsToShow * overlap) + avatarRadius;

    return SizedBox(
      width: width,
      height: avatarRadius * 2,
      child: Stack(
        children: [
          for (int i = 0; i < avatarsToShow; i++)
            Positioned(
              left: i * overlap,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage: NetworkImage(avatars[i]),
                backgroundColor: AppColors.neutral200,
              ),
            ),
          if (showPlusCircle)
            Positioned(
              left: avatarsToShow * overlap,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: AppColors.primary200,
                child: Text(
                  '+$remainingCount',
                  style: TextStyle(
                    fontSize: avatarRadius * 0.75,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
