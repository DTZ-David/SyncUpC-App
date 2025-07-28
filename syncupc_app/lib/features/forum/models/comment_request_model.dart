class CommentRequest {
  final String forumId;
  final String content;

  CommentRequest({
    required this.forumId,
    required this.content,
  });

  factory CommentRequest.fromJson(Map<String, dynamic> json) {
    return CommentRequest(
        forumId: json['forumId'] as String, content: json['content'] as String);
  }

  Map<String, dynamic> toJson() => {
        'forumId': forumId,
        'content': content,
      };
}
