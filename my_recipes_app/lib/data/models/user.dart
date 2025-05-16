class User {
  final int? id;
  final String email;
  final String password;
  final String? name;
  final String? createdAt;
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
        createdAt: json['created_at'],
        isAdmin: json['is_admin'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'name': name,
        'created_at': null,
        'is_admin': isAdmin,
      };
}
