import 'package:flutter/material.dart';
import 'package:syncupc/features/forum/models/comment_model.dart';
import 'package:syncupc/ui/forum/widgets/user_header.dart';

class ReplyCard extends StatelessWidget {
  final CommentModel reply;

  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserHeader(
            userName: reply.authorName,
            timeAgo: reply.timeAgo,
            avatarUrl: reply.authorProfilePicture,
          ),
          const SizedBox(height: 12),
          Text(
            reply.content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
