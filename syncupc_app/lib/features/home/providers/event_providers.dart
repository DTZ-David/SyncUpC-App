// services/auth_service.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/home/models/event_model.dart';
import 'package:syncupc/features/home/services/event_service.dart';

import '../../auth/providers/auth_providers.dart';

part 'event_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<EventModel>> getAllEventsForU(Ref ref) async {
  final token = ref.read(authTokenProvider);
  return await EventService().getEventsForU(token!);
}

@Riverpod(keepAlive: true)
Future<List<EventModel>> getAllEvents(Ref ref) async {
  final token = ref.read(authTokenProvider);
  return await EventService().getAllEvents(token!);
}

@riverpod
List<String> eventTags(Ref ref) {
  final eventsAsync = ref.watch(getAllEventsProvider);

  return eventsAsync.maybeWhen(
    data: (events) {
      final tagsSet = <String>{};

      for (final event in events) {
        tagsSet.addAll(event.tags);
      }

      return tagsSet.toList();
    },
    orElse: () => [],
  );
}

final selectedTagProvider = StateProvider<String?>((ref) => null);

// Provider para el texto de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider para eventos filtrados por búsqueda Y categoría
@riverpod
Future<List<EventModel>> filteredEventsForU(Ref ref) async {
  final events = await ref.watch(getAllEventsForUProvider.future);
  final selectedTag = ref.watch(selectedTagProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase().trim();

  var filteredEvents = events;

  // Filtrar por categoría si hay una seleccionada
  if (selectedTag != null) {
    filteredEvents = filteredEvents
        .where((event) => event.tags.contains(selectedTag))
        .toList();
  }

  // Filtrar por búsqueda si hay texto
  if (searchQuery.isNotEmpty) {
    filteredEvents = filteredEvents.where((event) {
      return event.eventTitle.toLowerCase().contains(searchQuery) ||
          event.eventObjective.toLowerCase().contains(searchQuery) ||
          event.tags.any((tag) => tag.toLowerCase().contains(searchQuery));
    }).toList();
  }

  return filteredEvents;
}

@riverpod
Future<List<EventModel>> filteredEventsNearby(Ref ref) async {
  final events = await ref.watch(getAllEventsProvider.future);
  final selectedTag = ref.watch(selectedTagProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase().trim();

  var filteredEvents = events;

  // Filtrar por categoría si hay una seleccionada
  if (selectedTag != null) {
    filteredEvents = filteredEvents
        .where((event) => event.tags.contains(selectedTag))
        .toList();
  }

  // Filtrar por búsqueda si hay texto
  if (searchQuery.isNotEmpty) {
    filteredEvents = filteredEvents.where((event) {
      return event.eventTitle.toLowerCase().contains(searchQuery) ||
          event.eventObjective.toLowerCase().contains(searchQuery) ||
          event.tags.any((tag) => tag.toLowerCase().contains(searchQuery));
    }).toList();
  }

  return filteredEvents;
}
