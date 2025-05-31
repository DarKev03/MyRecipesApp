import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/ingredient.dart';
import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:my_recipes_app/data/repositories/ingredient_repository.dart';
import 'package:my_recipes_app/data/repositories/recipe_ingredient_repository.dart';

class IngredientViewmodel extends ChangeNotifier {
  final RecipeIngredientRepository recipeIngredientRepository;
  final IngredientRepository ingredientRepository;

  List<RecipeIngredient> _allUserIngredients = [];
  //final List<RecipeIngredient> _allRecipeIngredients = [];
  // List<RecipeIngredient> _currentRecipeIngredients = [];

  List<RecipeIngredient> get allUserIngredients => _allUserIngredients;
  //List<RecipeIngredient> get allRecipeIngredients => _allRecipeIngredients;
  // List<RecipeIngredient> get currentRecipeIngredients =>
  //     _currentRecipeIngredients;

  IngredientViewmodel(
      {required this.recipeIngredientRepository,
      required this.ingredientRepository});

  Future<void> fetchIngredientsByUserId(int userId) async {
    try {
      _allUserIngredients =
          await recipeIngredientRepository.getIngredientsByUserId(userId);
      notifyListeners();
    } catch (e) {
      print("Error fetching ingredients: $e");
    }
  }

  // Future<void> fetchIngredientsByRecipeId(int recipeId) async {
  //   try {
  //     _currentRecipeIngredients =
  //         await recipeIngredientRepository.getIngredientsByRecipId(recipeId);
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error fetching ingredients by recipe ID: $e");
  //   }
  // }

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
      _allUserIngredients.removeWhere((ingredient) => ingredient.id == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting ingredient: $e");
    }
  }

  Future<void> deleteRecipeIngredient(int id) async {
    try {
      await recipeIngredientRepository.deleteRecipeIngredient(id);
      _allUserIngredients.removeWhere((ingredient) => ingredient.id == id);
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

  Future<void> updateRecipeIngredient(RecipeIngredient recipeIngredient) async {
    try {
      RecipeIngredient updatedIngredient = await recipeIngredientRepository
          .updateRecipeIngredient(recipeIngredient);
      _allUserIngredients = _allUserIngredients.map((ingredient) {
        return ingredient.id == updatedIngredient.id
            ? updatedIngredient
            : ingredient;
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error updating recipe ingredient: $e");
    }
  }
}
