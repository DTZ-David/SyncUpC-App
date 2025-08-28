// providers/event_type_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/registerEvent/models/event_campus_request.dart';
import 'package:syncupc/features/registerEvent/models/event_space_request.dart';
import 'package:syncupc/features/registerEvent/models/event_type_request.dart';
import 'package:syncupc/features/registerEvent/services/event_campus_request_service.dart';
import 'package:syncupc/features/registerEvent/services/event_space_request_service.dart';
import 'package:syncupc/features/registerEvent/services/event_type_request_service.dart';

import '../../auth/providers/auth_providers.dart';

part 'event_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<EventTypeRequest>> getAllEventTypes(Ref ref) async {
  final token = ref.read(authTokenProvider);
  return await EventTypeRequestService().getAllEventTypes(token!);
}

@Riverpod(keepAlive: true)
Future<List<EventCampusRequest>> getAllCampuses(Ref ref) async {
  final token = ref.read(authTokenProvider);
  return await EventCampusRequestService().getAllCampuses(token!);
}

@Riverpod(keepAlive: true)
Future<List<EventSpaceRequest>> getAllSpaces(Ref ref) async {
  final token = ref.read(authTokenProvider);
  return await EventSpaceRequestService().getAllSpaces(token!);
}
