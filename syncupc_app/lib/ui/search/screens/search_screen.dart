import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/design_system/molecules/search_bar.dart';
import 'package:syncupc/ui/search/widgets/categories_card.dart';
import 'package:syncupc/ui/search/widgets/events_card.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lista de categorías
    final categories = [
      {'title': 'Música', 'icon': Icons.music_note, 'color': Colors.cyan},
      {
        'title': 'Deportes',
        'icon': Icons.sports_soccer,
        'color': Colors.orange
      },
      {'title': 'Arte', 'icon': Icons.palette, 'color': Colors.purple},
      {'title': 'Tecnología', 'icon': Icons.computer, 'color': Colors.green},
    ];

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
              SearchBarDesign(filter: false),
              const SizedBox(height: 20),
              ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true, // Para que no ocupe todo el espacio
                physics:
                    const NeverScrollableScrollPhysics(), // Desactiva scroll interno
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CategoriesCard(
                      title: item['title'] as String,
                      icon: item['icon'] as IconData,
                      iconColor: item['color'] as Color,
                      onTap: () {
                        // Acción al pulsar la tarjeta
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 4),
              Align(
                alignment: Alignment.center,
                child: AppText.subtitle2(
                  "Eventos destacados",
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 112 / 133,
                children: [
                  EventsCard(
                    title: 'Concierto',
                    imagePath: 'assets/images/event_card2.png',
                  ),
                  EventsCard(
                    title: 'Feria',
                    imagePath: 'assets/images/event_card2.png',
                  ),
                  EventsCard(
                    title: 'Deportes',
                    imagePath: 'assets/images/event_card2.png',
                  ),
                  EventsCard(
                    title: 'Cultura',
                    imagePath: 'assets/images/event_card2.png',
                  ),
                  EventsCard(
                    title: 'Charla',
                    imagePath: 'assets/images/event_card2.png',
                  ),
                  EventsCard(
                    title: 'Startup',
                    imagePath: 'assets/images/event_card2.png',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
