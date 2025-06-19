import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/design_system/molecules/event_for_u_card.dart';

class HomeEventsForU extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> events;

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
                title: event['title'],
                timeText: '9 de Enero',
                timeHour: '9:00 PM',
                location: event['location'],
                attendeesText: event['attendeesText'],
                totalAttendees: event['totalAttendees'],
                attendeeAvatars: event['attendeeAvatars'],
                isNearby: true,
              ),
            );
          },
        ),
      ],
    );
  }
}
