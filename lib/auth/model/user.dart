class User {
  final String id;
  final String email;
  final String username;
  final List<String> roles;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '', // Provide default values if null
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}
