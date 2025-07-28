import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/forum/models/forum_model.dart';

class PostContent extends StatelessWidget {
  final ForumModel forumModel;
  const PostContent({super.key, required this.forumModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.body1(forumModel.content),
        const SizedBox(height: 12),
      ],
    );
  }
}
