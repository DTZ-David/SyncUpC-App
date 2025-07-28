import 'package:flutter/material.dart';

import 'action_buttons.dart';

class PostActions extends StatelessWidget {
  final int likes;
  final int comments;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostActions({
    super.key,
    required this.likes,
    required this.comments,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionButton(
          icon: Icons.thumb_up_outlined,
          text: likes.toString(),
          onTap: onLike,
        ),
        const SizedBox(width: 24),
        ActionButton(
          icon: Icons.chat_bubble_outline,
          text: comments.toString(),
          onTap: onComment,
        ),
        const SizedBox(width: 24),
        ActionButton(
          icon: Icons.share_outlined,
          text: "Share",
          onTap: onShare,
        ),
      ],
    );
  }
}
