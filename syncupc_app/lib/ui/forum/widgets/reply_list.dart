import 'package:flutter/material.dart';

import '../../../features/forum/models/forum_model.dart';
import 'reply_card.dart';

class RepliesList extends StatelessWidget {
  final ForumModel forum;
  const RepliesList({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: forum.comments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final reply = forum.comments[index];
        return ReplyCard(reply: reply);
      },
    );
  }
}
