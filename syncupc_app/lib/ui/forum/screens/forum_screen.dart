import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';

class ForumScreen extends ConsumerWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppText.heading1("Foro"),
            ),

            const SizedBox(height: 20),

            // Forum Topics List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _forumTopics.length,
                itemBuilder: (context, index) {
                  final topic = _forumTopics[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/event/forum/id');
                    },
                    child: _buildForumTopic(topic),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForumTopic(ForumTopic topic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(topic.avatarPath),
          ),

          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subtitle2(
                  topic.title,
                ),
                const SizedBox(height: 4),
                AppText.body3(
                  topic.userName,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    AppText.caption(
                      "${topic.replies} Replies",
                    ),
                    AppText.semiBold(
                      " • ",
                    ),
                    AppText.caption(
                      topic.createdDate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Modelo de datos para los temas del foro
class ForumTopic {
  final String title;
  final String userName;
  final String avatarPath;
  final int replies;
  final String createdDate;

  ForumTopic({
    required this.title,
    required this.userName,
    required this.avatarPath,
    required this.replies,
    required this.createdDate,
  });
}

// Datos de ejemplo
final List<ForumTopic> _forumTopics = [
  ForumTopic(
    title: "Real Pixel with Zeplin",
    userName: "Sarah Johnson",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    replies: 34,
    createdDate: "2 hours ago",
  ),
  ForumTopic(
    title: "Invision or Sketch Cloud?",
    userName: "Mike Chen",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    replies: 17,
    createdDate: "5 hours ago",
  ),
  ForumTopic(
    title: "Need Help for Github error",
    userName: "Emma Davis",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    replies: 81,
    createdDate: "1 day ago",
  ),
  ForumTopic(
    title: "Switching from Photoshop",
    userName: "Alex Rodriguez",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    replies: 54,
    createdDate: "2 days ago",
  ),
  ForumTopic(
    title: "Need UI Designer for Team",
    userName: "Lisa Wang",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    replies: 41,
    createdDate: "3 days ago",
  ),
  ForumTopic(
    title: "Dimag Ki Dahi Kardi",
    userName: "David Kim",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    replies: 43,
    createdDate: "1 week ago",
  ),
];
