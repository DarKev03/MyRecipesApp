class ShoppingListItem {
  final int? id;
  final int? shoppingListId;
  final int? ingredientId;
  final double? quantity;
  final String? ingredientName;
  final String? unit;

  ShoppingListItem({
    required this.id,
    required this.shoppingListId,
    required this.ingredientId,
    this.quantity,
    this.ingredientName,
    this.unit,
  });

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) =>
      ShoppingListItem(
        id: json['id'],
        shoppingListId: json['shoppingListId'],
        ingredientId: json['ingredientId'],
        quantity: (json['quantity'] as num?)?.toDouble(),
        ingredientName: json['ingredientName'],
        unit: json['unit'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'shoppingListId': shoppingListId,
        'ingredientId': ingredientId,
        'quantity': quantity,
        'ingredientName': ingredientName,
        'unit': unit,
      };
}
