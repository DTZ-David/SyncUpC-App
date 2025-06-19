import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/protons/colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String time;
  final String location;
  final String attendeesText;
  final String? imageUrl;
  final List<String> attendeeAvatars;
  final int totalAttendees; // Nuevo parámetro para el total de asistentes
  final VoidCallback? onTap;
  final bool isNearby;

  const EventCard({
    super.key,
    required this.title,
    required this.time,
    required this.location,
    required this.attendeesText,
    required this.totalAttendees, // Requerido para calcular el +X
    this.imageUrl,
    this.attendeeAvatars = const [],
    this.onTap,
    this.isNearby = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 263,
      width: 198,
      child: Card(
        surfaceTintColor: AppColors.white,
        child: Column(
          children: [
            Image.asset(imageUrl!, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: AppText.subtitle2(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/location.svg',
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(width: 4),
                    AppText.semiBold(location),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/calendar.svg',
                      width: 15,
                      height: 15,
                      colorFilter: ColorFilter.mode(
                          AppColors.primary200, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 4),
                    AppText.body3(time),
                  ],
                ),
              ),
            ),
            SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Texto expandido con margen derecho
                  Expanded(
                    child: AppText.profilePic(
                      attendeesText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildAvatarStack(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarStack() {
    if (attendeeAvatars.isEmpty) return const SizedBox.shrink();

    final int avatarsToShow =
        attendeeAvatars.length > 3 ? 3 : attendeeAvatars.length;
    final int remainingCount = totalAttendees - 3;
    final bool showPlusCircle = totalAttendees > 3;

    final double overlap = 10.0; // Espacio horizontal entre avatares

    final double width = showPlusCircle
        ? (avatarsToShow * overlap) + 24
        : (avatarsToShow * overlap) + 12;

    return SizedBox(
      width: width,
      height: 24,
      child: Stack(
        children: [
          for (int i = 0; i < avatarsToShow; i++)
            Positioned(
              left: i * overlap,
              child: CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(attendeeAvatars[i]),
                backgroundColor: AppColors.neutral200,
              ),
            ),
          if (showPlusCircle)
            Positioned(
              left: avatarsToShow * overlap,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.primary200,
                child: Text(
                  '+$remainingCount',
                  style: const TextStyle(
                    fontSize: 9,
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
