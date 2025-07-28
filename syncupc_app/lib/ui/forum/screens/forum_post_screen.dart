import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/features/forum/models/forum_model.dart';

import '../widgets/main_post_card.dart';
import '../widgets/reply_input_field.dart';
import '../widgets/reply_list.dart';

class ForumPostScreen extends ConsumerWidget {
  final ForumModel forum;

  const ForumPostScreen({
    super.key,
    required this.forum,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 8),
                children: [
                  MainPostCard(forumModel: forum),
                  ReplyInputField(forum.id),
                  SizedBox(height: 8),
                  RepliesList(forum: forum),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
