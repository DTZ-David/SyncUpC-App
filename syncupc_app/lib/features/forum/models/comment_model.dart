import 'package:intl/intl.dart';

import 'package:timeago/timeago.dart' as timeago;

class CommentModel {
  final String forumId;
  final String authorId;
  final String authorName;
  final String authorProfilePicture;
  final String content;
  final String time;

  CommentModel({
    required this.forumId,
    required this.authorId,
    required this.authorName,
    required this.authorProfilePicture,
    required this.content,
    required this.time,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      forumId: json['forumId'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String? ?? "Desconocido",
      authorProfilePicture: json['authorProfilePicture'] as String? ?? "",
      content: json['content'] as String,
      time: json['time'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'forumId': forumId,
        'authorId': authorId,
        'authorName': authorName,
        'authorProfilePicture': authorProfilePicture,
        'content': content,
        'time': time,
      };

  String get timeAgo {
    try {
      final parsedDate = DateFormat('M/d/yyyy h:mm a').parse(time);
      return timeago.format(parsedDate, locale: 'es');
    } catch (_) {
      return time;
    }
  }
}
