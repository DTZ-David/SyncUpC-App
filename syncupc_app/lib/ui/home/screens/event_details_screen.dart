import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/molecules/attendees_avatars.dart';
import 'package:syncupc/ui/home/widgets/confirmation_message.dart';

import '../../../features/home/models/event_model.dart';

class EventDetailsScreen extends ConsumerWidget {
  final EventModel event;
  const EventDetailsScreen(this.event, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary200,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AttendanceConfirmationPopup(
              title: "Confirmamos tu asistencia",
            ),
          );
        },
        child: const Icon(Icons.check, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: Image.network(
                  event.imageUrls.first.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText.heading3(
                        event.eventTitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, right: 20),
                    child: Row(
                      children: [
                        _circleIcon('assets/images/share.svg'),
                        const SizedBox(width: 8),
                        _circleIcon('assets/images/foro.svg'),
                        const SizedBox(width: 8),
                        _circleIcon('assets/images/bookmark_01.svg'),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: AppText.caption(
                        "${event.participantProfilePictures.length.toString()}, personas asisten",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AttendeesAvatars(
                      avatars: event.participantProfilePictures,
                      totalAttendees: event.participantProfilePictures.length,
                      avatarRadius: 18,
                    )
                  ],
                ),
              ),
              const _SectionTitle("Información del evento"),
              _EventDetailRow(
                icon: 'assets/images/calendar.svg',
                text: capitalizeFirstLetter(
                    DateFormat('EEEE, d \'de\' MMMM', 'es')
                        .format(event.eventDate)),
              ),
              _EventDetailRow(
                icon: 'assets/images/clock_settings.svg',
                text: DateFormat('h:mma', 'es')
                    .format(event.eventDate)
                    .toLowerCase(),
                iconColor: AppColors.primary200,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/location.svg',
                            width: 22,
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary200,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: AppText.body3(
                              event.eventLocation,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppText.body3(
                      "¿Cómo llegar?",
                      color: AppColors.primary200,
                    ),
                  ],
                ),
              ),
              const _SectionTitle("Detalles del evento"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.subtitle2(
                      event.eventObjective,
                    ),
                    const SizedBox(height: 8),
                    AppText.body2(
                      event.additionalDetails,
                      textAlign: TextAlign.justify,
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

Widget _circleIcon(String icon) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Center(
      child: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
        fit: BoxFit.scaleDown,
      ),
    ),
  );
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.topLeft,
        child: AppText.subtitle2(
          text,
          maxLines: 1,
          color: AppColors.neutral900,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _EventDetailRow extends StatelessWidget {
  final String icon;
  final String text;
  final Color? iconColor;

  const _EventDetailRow({
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 22,
            height: 22,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                : null,
          ),
          const SizedBox(width: 6),
          AppText.body2(text),
        ],
      ),
    );
  }
}
