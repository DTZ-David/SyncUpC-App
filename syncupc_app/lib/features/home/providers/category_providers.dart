// providers/category_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/home/models/category_request.dart';
import 'package:syncupc/features/home/services/event_category_service.dart';

import '../../auth/providers/auth_providers.dart';

part 'category_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<EventCategoryRequest>> getAllCategories(Ref ref) async {
  final token = ref.read(authTokenProvider);
  return await EventCategoryService().getAllCategories(token!);
}
