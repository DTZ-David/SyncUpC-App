import 'package:flutter/material.dart';

import 'action_buttons.dart';

class PostActions extends StatelessWidget {
  final int comments;
  final VoidCallback onComment;

  const PostActions({
    super.key,
    required this.comments,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 24),
        ActionButton(
          icon: Icons.chat_bubble_outline,
          text: comments.toString(),
          onTap: onComment,
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
