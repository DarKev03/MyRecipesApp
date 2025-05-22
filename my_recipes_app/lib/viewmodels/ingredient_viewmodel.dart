import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/ingredient.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:my_recipes_app/data/repositories/ingredient_repository.dart';
import 'package:my_recipes_app/data/repositories/recipe_ingredient_repository.dart';

class IngredientViewmodel extends ChangeNotifier {
  final RecipeIngredientRepository recipeIngredientRepository;
  final IngredientRepository ingredientRepository;

  List<RecipeIngredient> _allUserIngredients = [];

  List<RecipeIngredient> get allUserIngredients => _allUserIngredients;

  IngredientViewmodel(
      {required this.recipeIngredientRepository,
      required this.ingredientRepository});

  Future<void> fetchIngredientsByRecipe(Recipe recipe) async {
    try {
      _allUserIngredients =
          await recipeIngredientRepository.getIngredientsByRecipId(recipe.id);
      notifyListeners();
    } catch (e) {
      print("Error fetching ingredients: $e");
    }
  }

  Future<void> fetchIngredientsByUserId(int userId) async {
    try {
      _allUserIngredients =
          await recipeIngredientRepository.getIngredientsByUserId(userId);
      notifyListeners();
    } catch (e) {
      print("Error fetching ingredients: $e");
    }
  }

  Future<void> addIngredient(
      Ingredient ingredient, RecipeIngredient recipeIngredient) async {
    try {
      final finalIngredient =
          await ingredientRepository.createIngredient(ingredient);
      recipeIngredient.ingredientId = finalIngredient.id;
      final finalRecipeIngredient = await recipeIngredientRepository
          .createRecipeIngredient(recipeIngredient);
      _allUserIngredients.add(finalRecipeIngredient);
      notifyListeners();
    } catch (e) {
      print("Error adding ingredient: $e");
    }
  }

  // Añadir endpoint para eliminar por id ingrediente
}
