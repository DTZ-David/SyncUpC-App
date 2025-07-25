import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/bookmarks/service/bookmarks_service.dart';
import 'package:syncupc/features/home/models/event_model.dart';
import '../../auth/providers/auth_providers.dart';

part 'bookmarks_providers.g.dart';

@riverpod
Future<void> addEventFav(Ref ref, String eventId) async {
  final token = ref.read(authTokenProvider);
  return await BookmarksService().addEventFav(token!, eventId);
}

@Riverpod(keepAlive: true)
Future<List<EventModel>> getSavedEvents(Ref ref) async {
  final token = ref.read(authTokenProvider);
  return await BookmarksService().getSavedEvents(token!);
}

@riverpod
Future<void> removeSavedEvents(Ref ref, String eventId) async {
  final token = ref.read(authTokenProvider);
  return await BookmarksService().removeEventSaved(token!, eventId);
}
