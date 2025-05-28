
class ShoppingList {
  final int? id;
  final int? userId;
  final String? name;
  final DateTime? createdAt;

  ShoppingList({
    this.id,
    this.userId,
    this.name,
    this.createdAt,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'createdAt': createdAt,
      };
}
