import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/features/forum/models/forum_model.dart';

import '../../../features/forum/providers/forum_providers.dart';
import '../widgets/main_post_card.dart';
import '../widgets/reply_input_field.dart';
import '../widgets/reply_list.dart';

class ForumPostScreen extends ConsumerWidget {
  final String forumId; // CAMBIAR: recibir ID en lugar del objeto

  const ForumPostScreen({
    super.key,
    required this.forumId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumAsync = ref.watch(getForumByIdProvider(forumId));

    return forumAsync.when(
      data: (forum) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: _buildAppBar(context, forum),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 8),
                  children: [
                    MainPostCard(forumModel: forum),
                    ReplyInputField(forum.id),
                    const SizedBox(height: 8),
                    RepliesList(forum: forum),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error al cargar el foro'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(getForumByIdProvider(forumId)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ForumModel forum) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        forum.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}
