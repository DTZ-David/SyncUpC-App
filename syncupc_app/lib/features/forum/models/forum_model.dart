import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'comment_model.dart';

class ForumModel {
  final String id;
  final String eventId;
  final String authorId;
  final String authorName;
  final String authorProfilePicture;
  final String title;
  final String content;
  final List<CommentModel> comments;
  final String time;

  ForumModel({
    required this.id,
    required this.eventId,
    required this.authorId,
    required this.authorName,
    required this.authorProfilePicture,
    required this.title,
    required this.content,
    required this.comments,
    required this.time,
  });

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String? ?? "Desconocido",
      authorProfilePicture: json['authorProfilePicture'] as String? ?? "",
      title: json['title'] as String,
      content: json['content'] as String,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((c) => CommentModel.fromJson(c))
              .toList() ??
          [],
      time: json['time'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'eventId': eventId,
        'authorId': authorId,
        'authorName': authorName,
        'authorProfilePicture': authorProfilePicture,
        'title': title,
        'content': content,
        'comments': comments.map((c) => c.toJson()).toList(),
        'time': time,
      };

  String get timeAgo {
    try {
      final parsedDate = DateFormat('M/d/yyyy h:mm a').parse(time);
      return timeago.format(parsedDate, locale: 'es');
    } catch (_) {
      return time; // Devuelve el string original si falla el parseo
    }
  }
}
