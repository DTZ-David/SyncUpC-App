class ForumReply {
  final String userName;
  final String avatarPath;
  final String content;
  final String timeAgo;
  final int likes;
  final bool isLiked;

  ForumReply({
    required this.userName,
    required this.avatarPath,
    required this.content,
    required this.timeAgo,
    required this.likes,
    this.isLiked = false,
  });
}
