import 'package:flutter/material.dart';
import 'package:syncupc/features/forum/models/forum_model.dart';

import 'post_actions.dart';
import 'post_content.dart';
import 'user_header.dart';

class MainPostCard extends StatelessWidget {
  final ForumModel forumModel;
  const MainPostCard({super.key, required this.forumModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserHeader(
            userName: forumModel.authorName,
            timeAgo: forumModel.timeAgo,
            avatarUrl: forumModel.authorProfilePicture,
          ),
          const SizedBox(height: 16),
          PostContent(forumModel: forumModel),
          const SizedBox(height: 16),
          PostActions(
            likes: 12,
            comments: 34,
            onLike: () {},
            onComment: () {},
            onShare: () {},
          ),
        ],
      ),
    );
  }
}
