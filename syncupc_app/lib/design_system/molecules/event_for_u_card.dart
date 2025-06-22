import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/design_system/molecules/attendees_avatars.dart';

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
                AttendeesAvatars(
                  avatars: attendeeAvatars,
                  totalAttendees: totalAttendees,
                ),
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
}
