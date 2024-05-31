class User {
  final String id;
  final String email;
  final String fullname;
  final List<String> roles;

  User({
    required this.id,
    required this.email,
    required this.fullname,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '', // Provide default values if null
      email: json['email'] ?? '',
      fullname: json['fullname'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullname': fullname,
      'roles': roles,
    };
  }
}
