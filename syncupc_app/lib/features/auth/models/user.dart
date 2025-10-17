class User {
  final String id;
  final String name;
  final String photo;
  final String token;
  final String refreshToken;
  final String role;

  User({
    required this.id,
    required this.refreshToken,
    required this.name,
    required this.photo,
    required this.token,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json; // 👈 esto es CLAVE

    return User(
      id: data['id'] ?? data['userId'] ?? '',
      token: data['token'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
      name: data['name'] ?? '',
      photo: data['profilePicture'] ?? '',
      role: data['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'token': token,
      'refreshToken': refreshToken,
      'role': role,
    };
  }
}
