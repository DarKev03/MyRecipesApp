class RecipeIngredient {
  final int? id;
  final int? recipeId;
  int? ingredientId;
  final String? ingredientName;
  final double? quantity;
  final String? unit;
  final int? userId;

  RecipeIngredient({
    required this.id,
    required this.recipeId,
    required this.ingredientId,
    this.ingredientName,
    this.quantity,
    this.unit,
    this.userId,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      RecipeIngredient(
        id: json['id'],
        recipeId: json['recipeId'],
        ingredientId: json['ingredient'],
        ingredientName: json['ingredientName'],
        quantity: (json['quantity'] as num?)?.toDouble(),
        unit: json['unit'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipe': recipeId,
        'ingredient': ingredientId,
        'quantity': quantity,
        'unit': unit,
      };
}
