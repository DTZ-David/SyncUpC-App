class ChannelFlags {
  final bool push;
  final bool email;
  final bool whatsApp;

  ChannelFlags({
    required this.push,
    required this.email,
    required this.whatsApp,
  });

  factory ChannelFlags.allEnabled() =>
      ChannelFlags(push: true, email: true, whatsApp: true);

  Map<String, dynamic> toJson() => {
        'push': push,
        'email': email,
        'whatsApp': whatsApp,
      };
}
