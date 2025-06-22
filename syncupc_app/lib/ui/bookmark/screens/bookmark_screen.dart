import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

import '../widgets/bookmark_event.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> bookmarkedEvents = [
      {
        'day': 'Lunes',
        'date': '28',
        'month': 'Mayo',
        'title': 'TechTalk: Futuro de la IA',
        'location': 'Auditorio Central, UPC',
        'time': '10:00 AM',
        'isFavorite': true,
      },
      {
        'day': 'Miércoles',
        'date': '30',
        'month': 'Mayo',
        'title': 'Expo Innovación',
        'location': 'Sala de Exposiciones',
        'time': '2:00 PM',
        'isFavorite': false,
      },
      {
        'day': 'Viernes',
        'date': '02',
        'month': 'Junio',
        'title': 'Festival de Música',
        'location': 'Plaza Principal',
        'time': '6:00 PM',
        'isFavorite': true,
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.heading1("Mis Eventos"),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 24),
                itemCount: bookmarkedEvents.length,
                itemBuilder: (context, index) {
                  final event = bookmarkedEvents[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: BookmarkEvent(
                      day: event['day'],
                      date: event['date'],
                      month: event['month'],
                      title: event['title'],
                      location: event['location'],
                      time: event['time'],
                      isFavorite: event['isFavorite'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
