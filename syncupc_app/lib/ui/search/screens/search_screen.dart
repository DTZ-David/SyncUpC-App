import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/design_system/molecules/search_bar.dart';
import 'package:syncupc/features/home/providers/event_providers.dart';
import 'package:syncupc/ui/search/widgets/categories_card.dart';
import 'package:syncupc/ui/search/widgets/events_card.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(eventTagsProvider); // <-- dinámico
    final events = ref.watch(getAllEventsProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AppText.heading1(
                "Encuentra los mejores eventos para ti",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const SearchBarDesign(filter: false),
              const SizedBox(height: 20),
              tags.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: tags.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final tag = tags[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: CategoriesCard(
                            title: tag,
                            icon: Icons.label,
                            onTap: () {
                              // Aquí puedes implementar el filtrado por tag si quieres
                            },
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: AppText.subtitle2("Eventos destacados"),
              ),
              const SizedBox(height: 8),
              events.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
                data: (eventList) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 112 / 133,
                    children: eventList.take(6).map((event) {
                      return EventsCard(
                        onTap: () {
                          context.push(
                            '/event/details',
                            extra: event,
                          );
                        },
                        title: event.eventTitle,
                        imagePath: event.imageUrls.isNotEmpty
                            ? event.imageUrls.first
                            : 'assets/images/event_card2.png',
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
