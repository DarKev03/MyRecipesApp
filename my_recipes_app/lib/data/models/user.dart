class User {
  final int id;
  final String email;
  final String password;
  final String? name;
  final DateTime createdAt;
  final bool? isAdmin;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.createdAt,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        name: json['name'],
        createdAt: DateTime.parse(json['created_at']),
        isAdmin: json['is_admin'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'name': name,
        'created_at': createdAt.toIso8601String(),
        'is_admin': isAdmin,
      };
}
