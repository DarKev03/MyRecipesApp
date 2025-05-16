class ShoppingList {
  final int id;
  final int userId;
  final String name;
  final DateTime createdAt;

  ShoppingList({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'created_at': createdAt.toIso8601String(),
      };
}
