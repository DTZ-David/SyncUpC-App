class ForumRequest {
  final String eventId;
  final String title;
  final String content;

  ForumRequest({
    required this.eventId,
    required this.title,
    required this.content,
  });

  factory ForumRequest.fromJson(Map<String, dynamic> json) {
    return ForumRequest(
        eventId: json['eventId'] as String,
        title: json['title'] as String,
        content: json['content'] as String);
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'title': title,
        'content': content,
      };
}
