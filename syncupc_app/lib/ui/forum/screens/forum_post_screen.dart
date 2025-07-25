import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumPostScreen extends ConsumerWidget {
  final String postTitle;

  const ForumPostScreen({
    super.key,
    required this.postTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          postTitle,
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
      ),
      body: Column(
        children: [
          // Post principal
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Usuario del post principal
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/32.jpg"),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sarah Johnson",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "2 hours ago",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 20,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Contenido del post
                Text(
                  "I've been working with Zeplin for pixel-perfect designs and I'm wondering if anyone has experience with the Real Pixel feature. How does it compare to traditional design handoff methods?\n\nI'm particularly interested in:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 12),

                // Lista de puntos
                ...[
                  "Accuracy compared to manual specs",
                  "Integration with development workflow",
                  "Team collaboration features"
                ].map(
                  (point) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• ", style: TextStyle(color: Colors.grey[700])),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Acciones del post
                Row(
                  children: [
                    _buildActionButton(Icons.thumb_up_outlined, "12"),
                    const SizedBox(width: 24),
                    _buildActionButton(Icons.chat_bubble_outline, "34"),
                    const SizedBox(width: 24),
                    _buildActionButton(Icons.share_outlined, "Share"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Respuestas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _replies.length,
              itemBuilder: (context, index) {
                final reply = _replies[index];
                return _buildReply(reply);
              },
            ),
          ),

          // Campo para nueva respuesta
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/32.jpg"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write a reply...",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildReply(ForumReply reply) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Usuario que responde
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(reply.avatarPath),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reply.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    reply.timeAgo,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (reply.isLiked)
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 16,
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Contenido de la respuesta
          Text(
            reply.content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          // Acciones de la respuesta
          Row(
            children: [
              _buildActionButton(
                  Icons.thumb_up_outlined, reply.likes.toString()),
              const SizedBox(width: 16),
              _buildActionButton(Icons.chat_bubble_outline, "Reply"),
            ],
          ),
        ],
      ),
    );
  }
}

// Modelo para las respuestas
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

// Datos de ejemplo para las respuestas
final List<ForumReply> _replies = [
  ForumReply(
    userName: "Mike Chen",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    content:
        "I've been using Real Pixel for about 6 months now and it's been a game changer for our team. The accuracy is spot on and it integrates seamlessly with our development workflow.",
    timeAgo: "1 hour ago",
    likes: 8,
    isLiked: true,
  ),
  ForumReply(
    userName: "Emma Davis",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    content:
        "Great question! I'd also add that the collaboration features are really helpful. Our developers can leave comments directly on the designs.",
    timeAgo: "45 minutes ago",
    likes: 5,
  ),
  ForumReply(
    userName: "Alex Rodriguez",
    avatarPath: "https://randomuser.me/api/portraits/men/32.jpg",
    content:
        "One thing to consider is the learning curve. It took our team about a week to get fully comfortable with all the features, but it was worth it.",
    timeAgo: "30 minutes ago",
    likes: 3,
  ),
];
