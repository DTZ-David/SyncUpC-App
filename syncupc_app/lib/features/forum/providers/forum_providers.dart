import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/forum/models/comment_request_model.dart';
import 'package:syncupc/features/forum/models/forum_model.dart';
import 'package:syncupc/features/forum/services/forum_service.dart';

import '../../auth/providers/auth_providers.dart';
import '../models/forum_request_model.dart';

part 'forum_providers.g.dart';

@riverpod
Future<List<ForumModel>> getalltopicsforevent(Ref ref, String eventId) async {
  final token = ref.read(authTokenProvider);
  return await ForumService().getForum(token!, eventId);
}

@riverpod
Future<void> registerForumTopic(Ref ref, ForumRequest request) async {
  final token = ref.read(authTokenProvider);
  return await ForumService().registerTopic(token!, request);
}

@riverpod
Future<void> addcomment(Ref ref, CommentRequest request) async {
  final token = ref.read(authTokenProvider);
  return await ForumService().addComment(token!, request);
}
