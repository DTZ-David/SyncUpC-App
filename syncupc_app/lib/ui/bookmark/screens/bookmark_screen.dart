import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/bookmarks/providers/bookmarks_providers.dart';

import '../widgets/bookmark_event.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    // Invalidar el provider cada vez que entre a la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(getSavedEventsProvider);
    });
  }

  Future<void> _onRefresh() async {
    // Invalidar y refrescar los datos
    ref.invalidate(getSavedEventsProvider);
    // Esperar un momento para que se complete la recarga
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
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
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: savedEventsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            AppText.body2(
                              'Error al cargar eventos',
                            ),
                            const SizedBox(height: 8),
                            AppText.body2(
                              '$err',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                ref.invalidate(getSavedEventsProvider);
                              },
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  data: (savedEvents) {
                    if (savedEvents.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark_border,
                                  size: 64,
                                  color: AppColors.neutral400,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "No tienes eventos guardados",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.neutral600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Desliza hacia abajo para refrescar",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.neutral500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
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
            ),
          ],
        ),
      ),
    );
  }
}
