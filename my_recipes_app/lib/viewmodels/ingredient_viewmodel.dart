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
          await recipeIngredientRepository.getIngredientsByRecipId(recipe.id!);
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

  Future<Ingredient> addIngredient(Ingredient ingredient) async {
    try {
      Ingredient ingredientSaved =
          await ingredientRepository.createIngredient(ingredient);
      notifyListeners();
      return ingredientSaved;
    } catch (e) {
      print("Error adding ingredient: $e");
      return ingredient;
    }
  }

  Future<void> deleteIngredient(int id) async {
    try {
      await ingredientRepository.deleteIngredient(id);
      notifyListeners();
    } catch (e) {
      print("Error deleting ingredient: $e");
    }
  }

  Future<void> addRecipeIngredient(RecipeIngredient recipeIngredient) async {
    try {
      RecipeIngredient recipeIngredientSaved = await recipeIngredientRepository
          .createRecipeIngredient(recipeIngredient);
      _allUserIngredients.add(recipeIngredientSaved);
      notifyListeners();
    } catch (e) {
      print("Error adding recipe ingredient: $e");
    }
  }

  // Añadir endpoint para eliminar por id ingrediente
}
