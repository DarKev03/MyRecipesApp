import 'package:my_recipes_app/data/models/shopping_list_item.dart';

class ShoppingList {
  final int? id;
  final int? userId;
  final String? name;
  final List<ShoppingListItem>? items;
  final DateTime? createdAt;

  ShoppingList({
    this.id,
    this.userId,
    this.name,
    this.createdAt,
    this.items = const [],
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
        id: json['id'],
        userId: json['userId'],
        items: (json['items'] as List<dynamic>?)
            ?.map((item) => ShoppingListItem.fromJson(item))
            .toList(),
        name: json['name'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'createdAt': createdAt!.toIso8601String(),
        'items': items?.map((item) => item.toJson()).toList(),
      };
}
