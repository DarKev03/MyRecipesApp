class RecipeIngredient {
  final int id;
  final int recipeId;
  final int ingredientId;
  final double? quantity;
  final String? unit;

  RecipeIngredient({
    required this.id,
    required this.recipeId,
    required this.ingredientId,
    this.quantity,
    this.unit,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      RecipeIngredient(
        id: json['id'],
        recipeId: json['recipe_id'],
        ingredientId: json['ingredient_id'],
        quantity: (json['quantity'] as num?)?.toDouble(),
        unit: json['unit'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipe_id': recipeId,
        'ingredient_id': ingredientId,
        'quantity': quantity,
        'unit': unit,
      };
}
