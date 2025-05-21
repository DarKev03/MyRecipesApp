class RecipeIngredient {
  final int? id;
  final int? recipeId;
  int? ingredientId;
  final String? ingredientName;
  final double? quantity;
  final String? unit;

  RecipeIngredient({
    required this.id,
    required this.recipeId,
    required this.ingredientId,
    this.ingredientName,
    this.quantity,
    this.unit,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      RecipeIngredient(
        id: json['id'],
        recipeId: json['recipe'],
        ingredientId: json['ingredient'],
        ingredientName: json['ingredientName'],
        quantity: (json['quantity'] as num?)?.toDouble(),
        unit: json['unit'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipe': recipeId,
        'ingredient': ingredientId,
        'quantity': quantity,
        'unit': unit,
      };
}
