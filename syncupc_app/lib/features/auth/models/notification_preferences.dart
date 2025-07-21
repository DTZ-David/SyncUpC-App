import 'channel_flags.dart';

class NotificationPreferences {
  final ChannelFlags eventReminder;
  final ChannelFlags eventUpdate;
  final ChannelFlags forumReply;
  final ChannelFlags forumMention;

  NotificationPreferences({
    required this.eventReminder,
    required this.eventUpdate,
    required this.forumReply,
    required this.forumMention,
  });

  /// Preferencias por defecto: todo activado
  factory NotificationPreferences.defaultPrefs() => NotificationPreferences(
        eventReminder: ChannelFlags.allEnabled(),
        eventUpdate: ChannelFlags.allEnabled(),
        forumReply: ChannelFlags.allEnabled(),
        forumMention: ChannelFlags.allEnabled(),
      );

  Map<String, dynamic> toJson() => {
        'eventReminder': eventReminder.toJson(),
        'eventUpdate': eventUpdate.toJson(),
        'forumReply': forumReply.toJson(),
        'forumMention': forumMention.toJson(),
      };
}
