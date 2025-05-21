import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:my_recipes_app/data/services/recipe_ingredient_service.dart';

class RecipeIngredientRepository {
  RecipeIngredientService recipeIngredientService = RecipeIngredientService();

  Future<List<RecipeIngredient>> getIngredientsByRecipId(int recipeId) async {
    return await recipeIngredientService.getIngredientsByRecipeId(recipeId);
  }

  Future<List<RecipeIngredient>> getIngredientsByUserId(int userId) async {
    return await recipeIngredientService.getIngredientsByUserId(userId);
  }

  Future<RecipeIngredient> createRecipeIngredient(
      RecipeIngredient recipeIngredient) async {
    return await recipeIngredientService
        .createRecipeIngredient(recipeIngredient);
  }

  Future<void> deleteRecipeIngredient(int id) async {
    return await recipeIngredientService.deleteRecipeIngredient(id);
  }
}
