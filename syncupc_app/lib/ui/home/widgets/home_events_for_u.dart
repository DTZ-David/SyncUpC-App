import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/design_system/molecules/event_for_u_card.dart';
import 'package:syncupc/features/home/models/event_model.dart';

class HomeEventsForU extends StatelessWidget {
  final String title;
  final List<EventModel> events;

  const HomeEventsForU({
    super.key,
    required this.title,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título y acción
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.feed(title),
            AppText(
              "Ver más",
              style: TextStyle(
                color: AppColors.primary200,
                fontFamily: 'Nunito',
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Lista de tarjetas vertical
        ListView.builder(
          itemCount: events.length,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Desactiva scroll interno
          itemBuilder: (context, index) {
            final event = events[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: EventForUCard(
                title: event.eventTitle,
                timeText: capitalizeFirstLetter(
                    DateFormat('EEEE, d \'de\' MMMM', 'es')
                        .format(event.eventDate)),
                timeHour: DateFormat('h:mma', 'es')
                    .format(event.eventDate)
                    .toLowerCase(), // Ej: 4:03pm
                isNearby: true,
                location: event.eventLocation,
                attendeesText: 'Participantes',
                totalAttendees: event.participantProfilePictures.length,
                attendeeAvatars: event.participantProfilePictures,
              ),
            );
          },
        ),
      ],
    );
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
