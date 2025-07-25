import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/bookmarks/providers/bookmarks_providers.dart';

import '../widgets/bookmark_event.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedEventsAsync = ref.watch(getSavedEventsProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.heading1("Mis Eventos"),
            const SizedBox(height: 12),

            // Manejo del estado del provider
            Expanded(
              child: savedEventsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Text('Error: $err'),
                ),
                data: (savedEvents) {
                  if (savedEvents.isEmpty) {
                    return const Center(
                      child: Text("No tienes eventos guardados."),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: savedEvents.length,
                    itemBuilder: (context, index) {
                      final event = savedEvents[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: BookmarkEvent(
                          event: event,
                        ),
                      );
                    },
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
