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
