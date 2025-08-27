import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

import '../../../features/forum/models/forum_model.dart';
import '../../../features/forum/providers/forum_providers.dart';

class ForumScreen extends ConsumerWidget {
  final String eventId;
  const ForumScreen(this.eventId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumTopicsAsync = ref.watch(getalltopicsforeventProvider(eventId));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header con botón para crear
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(child: AppText.heading1("Foro")),
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: AppColors.primary200,
                    onPressed: () {
                      context.push('/event/forum/createTopic', extra: eventId);
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Estado del provider
            Expanded(
              child: forumTopicsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
                data: (topics) {
                  if (topics.isEmpty) {
                    return const Center(
                        child: Text('No hay temas en el foro.'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      // Fuerza recarga del provider
                      ref.invalidate(getalltopicsforeventProvider(eventId));
                    },
                    child: ListView.builder(
                      physics:
                          const AlwaysScrollableScrollPhysics(), // Asegura que siempre se pueda hacer pull even si no hay scroll
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        return _buildForumTopic(context, ref, topic);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForumTopic(
      BuildContext context, WidgetRef ref, ForumModel topic) {
    return GestureDetector(
      onTap: () {
        context.push('/event/forum/forumPostDetails', extra: topic.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(topic.authorProfilePicture)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: nombre + tiempo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppText.body2(
                          topic.authorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppText.caption(
                        topic.timeAgo,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Título del foro
                  AppText.heading3(
                    topic.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Comentarios
                  AppText.body3(
                    "${topic.comments.length} respuestas",
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
