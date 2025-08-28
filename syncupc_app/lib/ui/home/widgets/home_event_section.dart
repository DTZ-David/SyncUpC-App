import 'package:intl/intl.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing_for_provider.dart';
import 'package:syncupc/design_system/molecules/event_card.dart';

import '../../../features/home/models/event_model.dart';

class HomeEventsSection extends ConsumerWidget {
  final String title;
  final List<EventModel> events;

  const HomeEventsSection({
    super.key,
    required this.title,
    required this.events,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.feed(title),
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
                child: GestureDetector(
                  onTap: () {
                    context.push(
                      '/event/details',
                      extra: event,
                    );
                  },
                  child: EventCard(
                    title: event.eventTitle,
                    time: capitalizeFirstLetter(
                        DateFormat('EEEE, d \'de\' MMMM', 'es')
                            .format(event.eventStartDate)),
                    location: event.space.name,
                    attendeesText: 'Participantes', // Puedes mejorar esto
                    totalAttendees: event.participantProfilePictures.length,
                    imageUrl:
                        event.imageUrls.isNotEmpty ? event.imageUrls.first : '',
                    attendeeAvatars: event.participantProfilePictures,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
