class User {
  final String name;
  final String photo;
  final String token;
  final String role;

  User({
    required this.name,
    required this.photo,
    required this.token,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      token: json['token'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo': photo,
      'token': token,
      'role': role,
    };
  }
}
