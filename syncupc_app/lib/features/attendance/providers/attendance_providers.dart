import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/attendance/services/attendance_services.dart';

import '../../auth/providers/auth_providers.dart';

part 'attendance_providers.g.dart';

@riverpod
Future<String> checkIn(Ref ref, String eventId) async {
  final token = ref.read(authTokenProvider);
  return await AttendanceService().checkIn(token!, eventId);
}
