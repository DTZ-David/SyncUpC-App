// bookmarks_state_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/bookmarks/service/bookmarks_service.dart';
import '../../auth/providers/auth_providers.dart';

part 'bookmarks_state_providers.g.dart';

// Proveedor para mantener el estado de los eventos guardados
@Riverpod(keepAlive: true)
class BookmarksState extends _$BookmarksState {
  @override
  Set<String> build() {
    return <String>{};
  }

  void addBookmark(String eventId) {
    state = {...state, eventId};
  }

  void removeBookmark(String eventId) {
    state = {...state}..remove(eventId);
  }

  bool isBookmarked(String eventId) {
    return state.contains(eventId);
  }
}

// Provider para agregar/remover favoritos con actualización de estado
@riverpod
class BookmarkToggle extends _$BookmarkToggle {
  @override
  FutureOr<void> build(String eventId) {
    return null; // Retorna null en lugar de no retornar nada
  }

  Future<void> toggle() async {
    // Solo actualizar si no está cargando
    if (state.isLoading) return;

    state = const AsyncValue.loading();

    try {
      final token = ref.read(authTokenProvider);
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final bookmarksState = ref.read(bookmarksStateProvider.notifier);
      final isCurrentlyBookmarked =
          ref.read(bookmarksStateProvider).contains(eventId);

      if (isCurrentlyBookmarked) {
        // Remover de favoritos
        await BookmarksService().removeEventSaved(token, eventId);
        bookmarksState.removeBookmark(eventId);
      } else {
        // Agregar a favoritos
        await BookmarksService().addEventFav(token, eventId);
        bookmarksState.addBookmark(eventId);
      }

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow; // Re-lanzar el error para que pueda ser manejado en el UI
    }
  }
}

// Provider para inicializar los bookmarks
@riverpod
Future<void> initializeBookmarks(Ref ref) async {
  try {
    final token = ref.read(authTokenProvider);
    if (token == null) return;

    final savedEvents = await BookmarksService().getSavedEvents(token);
    final bookmarksState = ref.read(bookmarksStateProvider.notifier);

    final eventIds = savedEvents.map((event) => event.id).toSet();
    bookmarksState.state = eventIds;
  } catch (e) {
    // Manejar error silenciosamente o log
    print('Error inicializando bookmarks: $e');
  }
}
