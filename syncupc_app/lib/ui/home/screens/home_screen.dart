// HomeScreen actualizado para usar los nuevos providers con búsqueda
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/molecules/search_bar.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import 'package:syncupc/features/home/models/event_model.dart';
import 'package:syncupc/features/home/providers/event_providers.dart';
import 'package:syncupc/ui/home/exports/home.dart';
import 'package:syncupc/ui/home/widgets/home_events_for_u.dart';
import '../../../features/auth/providers/auth_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final selectedTag = ref.watch(selectedTagProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    // Usar los providers filtrados
    final filteredEventsForU = ref.watch(filteredEventsForUProvider);
    final filteredEventsNearby = ref.watch(filteredEventsNearbyProvider);

    // Para mostrar los eventos originales cuando no hay filtros
    final originalEventsForU = ref.watch(getAllEventsForUProvider);
    final originalEventsNearby = ref.watch(getAllEventsProvider);

    final hasActiveFilters = selectedTag != null || searchQuery.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(getAllEventsForUProvider);
                ref.invalidate(getAllEventsProvider);
                ref.invalidate(currentUserProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(
                      userName: user?.name ?? 'Invitado',
                      location: "Valledupar",
                      profileImagePath: user?.photo ?? '',
                    ),
                    const SizedBox(height: 24),
                    const SearchBarDesign(filter: true),
                    const SizedBox(height: 24),
                    const HomeCategories(),

                    const SizedBox(height: 12),

                    // Eventos Para Ti
                    if (hasActiveFilters)
                      filteredEventsForU.when(
                        data: (events) => _buildEventsSection(
                          "Eventos Para Ti",
                          events,
                          isFiltered: true,
                          onClearFilters: () => _clearAllFilters(ref),
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, _) =>
                            Center(child: Text("Error: $error")),
                      )
                    else
                      originalEventsForU.when(
                        data: (events) => HomeEventsSection(
                          title: "Eventos Para Ti",
                          events: events,
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, _) =>
                            Center(child: Text("Error: $error")),
                      ),

                    const SizedBox(height: 12),

                    // Eventos Cercanos
                    if (hasActiveFilters)
                      filteredEventsNearby.when(
                        data: (events) => _buildEventsSection(
                          "Eventos Cercanos",
                          events,
                          isFiltered: true,
                          onClearFilters: () => _clearAllFilters(ref),
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, _) =>
                            Center(child: Text("Error: $error")),
                      )
                    else
                      originalEventsNearby.when(
                        data: (events) => HomeEventsNearby(
                          title: "Eventos Cercanos",
                          events: events,
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, _) =>
                            Center(child: Text("Error: $error")),
                      ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsSection(
    String title,
    List<EventModel> events, {
    required bool isFiltered,
    VoidCallback? onClearFilters,
  }) {
    if (events.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: AppColors.neutral400,
            ),
            const SizedBox(height: 16),
            AppText.body1(
              "No se encontraron eventos",
              color: AppColors.neutral500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppText.body2(
              "Intenta cambiar los filtros de búsqueda",
              color: AppColors.neutral400,
              textAlign: TextAlign.center,
            ),
            if (onClearFilters != null) ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: onClearFilters,
                child: const Text("Ver todos los eventos"),
              ),
            ],
          ],
        ),
      );
    }

    // Usar el componente apropiado según el título
    if (title.contains("Eventos Para Ti")) {
      return HomeEventsSection(
        title: "$title (${events.length})",
        events: events,
      );
    } else {
      return HomeEventsNearby(
        title: "$title (${events.length})",
        events: events,
      );
    }
  }

  void _clearAllFilters(WidgetRef ref) {
    ref.read(selectedTagProvider.notifier).state = null;
    ref.read(searchQueryProvider.notifier).state = '';
  }

  String getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}
