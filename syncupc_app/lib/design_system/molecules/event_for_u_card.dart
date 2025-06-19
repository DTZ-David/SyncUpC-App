import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class EventForUCard extends StatelessWidget {
  final String title;
  final String timeText;
  final String timeHour;
  final String location;
  final String attendeesText;
  final List<String> attendeeAvatars;
  final int totalAttendees;
  final VoidCallback? onTap;
  final bool isNearby;

  const EventForUCard({
    super.key,
    required this.title,
    required this.timeText,
    required this.timeHour,
    required this.location,
    required this.attendeesText,
    required this.attendeeAvatars,
    required this.totalAttendees,
    this.onTap,
    required this.isNearby,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 230,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAvatarStack(),
                const SizedBox(width: 4),
                Expanded(
                  child:
                      AppText.body3(attendeesText, color: AppColors.neutral600),
                ),
                if (isNearby) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AppText.caption('Cerca de ti',
                        color: AppColors.neutral900),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 15),
            AppText.subtitle2(title, color: AppColors.neutral800),
            SizedBox(height: 2),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/location.svg',
                  width: 8,
                  height: 8,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: AppText.semiBold(location,
                      color: AppColors.neutral900, maxLines: 1),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/calendar.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 6),
                AppText.caption(timeText, color: AppColors.neutral600),
                Spacer(),
                Container(
                  height: 28,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: AppColors.primary200),
                  child: Center(
                      child: AppText(
                    timeHour,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  )),
                )
              ],
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
