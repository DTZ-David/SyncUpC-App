import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/design_system/molecules/event_card.dart';

class HomeEventsSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> events;

  const HomeEventsSection({
    super.key,
    required this.title,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.feed(title),
            AppText("Ver más",
                style: TextStyle(
                  color: AppColors.primary200,
                  fontFamily: 'Nunito',
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary200,
                )),
          ],
        ),
        SizedBox(
          height: 283,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            padding: const EdgeInsets.only(top: 8),
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 12,
                  right: index == events.length - 1 ? 0 : 0,
                ),
                child: EventCard(
                  title: event['title'],
                  time: event['time'],
                  location: event['location'],
                  attendeesText: event['attendeesText'],
                  totalAttendees: event['totalAttendees'],
                  imageUrl: event['imageUrl'],
                  attendeeAvatars:
                      List<String>.from(event['attendeeAvatars'] ?? []),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
