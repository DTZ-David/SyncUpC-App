import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/services/career_service.dart';

import '../../home/models/career.dart';

part 'career_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Career>> getAllCareers(Ref ref) async {
  return await CareerService().fetchCareers();
}
