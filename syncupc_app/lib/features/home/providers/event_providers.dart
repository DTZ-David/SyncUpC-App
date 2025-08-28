// services/auth_service.dart

// ignore_for_file: collection_methods_unrelated_type

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

final selectedTagProvider = StateProvider<String?>((ref) => null);

// Provider para el texto de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

@riverpod
Future<List<EventModel>> filteredEventsForU(Ref ref) async {
  final events = await ref.watch(getAllEventsForUProvider.future);
  final selectedTag = ref.watch(selectedTagProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase().trim();

  var filteredEvents = events;

  // Filtrar por categoría seleccionada
  if (selectedTag != null) {
    filteredEvents = filteredEvents.where((event) {
      final categoryNames = event.categories.map((c) => c.name).toList();
      return categoryNames.contains(selectedTag);
    }).toList();
  }

  // Filtrar por búsqueda si hay texto
  if (searchQuery.isNotEmpty) {
    filteredEvents = filteredEvents.where((event) {
      final categoryNames =
          event.categories.map((c) => c.name.toLowerCase()).toList();

      return event.eventTitle.toLowerCase().contains(searchQuery) ||
          event.eventObjective.toLowerCase().contains(searchQuery) ||
          categoryNames.any((c) => c.contains(searchQuery));
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

  if (selectedTag != null) {
    filteredEvents = filteredEvents
        .where((event) => event.categories.contains(selectedTag))
        .toList();
  }

  // Filtrar por búsqueda si hay texto
  if (searchQuery.isNotEmpty) {
    filteredEvents = filteredEvents.where((event) {
      final categoryNames =
          event.categories.map((c) => c.name.toLowerCase()).toList();

      return event.eventTitle.toLowerCase().contains(searchQuery) ||
          event.eventObjective.toLowerCase().contains(searchQuery) ||
          categoryNames.any((c) => c.contains(searchQuery));
    }).toList();
  }

  return filteredEvents;
}
