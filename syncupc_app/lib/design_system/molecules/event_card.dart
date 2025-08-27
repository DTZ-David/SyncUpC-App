import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/molecules/attendees_avatars.dart';
import 'package:syncupc/design_system/protons/colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String time;
  final String location;
  final String attendeesText;
  final String? imageUrl;
  final List<String> attendeeAvatars;
  final int totalAttendees;
  final VoidCallback? onTap;
  final bool isNearby;

  const EventCard({
    super.key,
    required this.title,
    required this.time,
    required this.location,
    required this.attendeesText,
    required this.totalAttendees,
    this.imageUrl,
    this.attendeeAvatars = const [],
    this.onTap,
    this.isNearby = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 263,
        width: 198,
        child: Card(
          surfaceTintColor: AppColors.white,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: imageUrl == null || imageUrl!.isEmpty
                    ? Container(
                        height: 140,
                        width: double.infinity,
                        color: Colors.grey[100],
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : Image.network(
                        imageUrl!,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 140,
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/logo.svg',
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
              ),
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
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/location.svg',
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      // <- Esto limita el ancho del texto
                      child: AppText.semiBold(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // <- agrega "..."
                      ),
                    ),
                  ],
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
                    AttendeesAvatars(
                      avatars: attendeeAvatars,
                      totalAttendees: totalAttendees,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
