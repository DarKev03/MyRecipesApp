class ShoppingListItem {
  final int id;
  final int shoppingListId;
  final int ingredientId;
  final double? quantity;
  final String? unit;

  ShoppingListItem({
    required this.id,
    required this.shoppingListId,
    required this.ingredientId,
    this.quantity,
    this.unit,
  });

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) =>
      ShoppingListItem(
        id: json['id'],
        shoppingListId: json['shopping_list_id'],
        ingredientId: json['ingredient_id'],
        quantity: (json['quantity'] as num?)?.toDouble(),
        unit: json['unit'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'shopping_list_id': shoppingListId,
        'ingredient_id': ingredientId,
        'quantity': quantity,
        'unit': unit,
      };
}
